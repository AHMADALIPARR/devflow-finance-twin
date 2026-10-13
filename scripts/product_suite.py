"""Source-backed product inventory, CPU checks and reproducible source bundles.

Original source licenses remain authoritative; this tool does not relicense them.
Uses only the Python standard library. Never loads models or GPU frameworks.
"""
from __future__ import annotations

import argparse
import ast
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import zipfile

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / "products/catalog.json"
REPORTS = ROOT / "products/reports"


def git(*args):
    return subprocess.check_output(["git", *args], cwd=ROOT).decode("utf-8", "replace")


def catalog():
    data = json.loads(CATALOG.read_text(encoding="utf-8"))
    ids = [p["id"] for p in data["products"]]
    if len(ids) != len(set(ids)):
        raise ValueError("Duplicate product ids")
    for product in data["products"]:
        for dependency in product["dependencies"]:
            if dependency not in ids:
                raise ValueError(f"Unknown dependency: {dependency}")
        for root in product["roots"]:
            if not (ROOT / root).resolve().is_relative_to(ROOT):
                raise ValueError(f"Invalid source root: {root}")
            if not (ROOT / root).exists():
                raise ValueError(f"Missing source root: {root}")
    return data


def paths():
    tracked = set(git("ls-files", "-z", "--cached", "--others", "--exclude-standard").split("\0")) - {""}
    # Generated evidence is excluded to prevent the inventory hashing itself.
    return sorted(p for p in tracked if not p.startswith("products/reports/"))


def owner(path, products):
    for product in products:
        if any(root == "." or path == root or path.startswith(root + "/")
               for root in product["roots"]):
            return product["id"]
    raise ValueError(f"Unowned path: {path}")


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def inventory():
    data = catalog()
    records, syntax_errors = [], []
    for path in paths():
        raw = (ROOT / path).read_bytes()
        binary = b"\0" in raw
        text = raw.decode("utf-8", "replace") if not binary else ""
        if path.endswith(".py"):
            try:
                ast.parse(raw, filename=path)
            except (SyntaxError, ValueError) as exc:
                syntax_errors.append({"path": path, "line": getattr(exc, "lineno", None), "error": str(exc)})
        records.append({"path": path, "product": owner(path, data["products"]),
                        "bytes": len(raw), "text_lines": len(text.splitlines()), "binary": binary,
                        "sha256": hashlib.sha256(raw).hexdigest()})
    commits = []
    for line in git("log", "--reverse", "--format=%H%x09%ad%x09%s", "--date=iso-strict",
                    data["baseline"] + ".." + data["reviewed_revision"]).splitlines():
        sha, date, subject = line.split("\t", 2)
        changed = git("diff-tree", "--root", "--no-commit-id", "--name-only", "-r", "-m", sha).splitlines()
        commits.append({"sha": sha, "date": date, "subject": subject,
                        "products": sorted({owner(p, data["products"]) for p in changed}),
                        "changed_paths": sorted(set(changed))})
    report = {"revision": git("rev-parse", data["reviewed_revision"]).strip(),
              "baseline": data["baseline"], "commit_count": len(commits),
              "files": records, "python_syntax_errors": syntax_errors}
    write_json(REPORTS / "source-inventory.json", report)
    write_json(REPORTS / "commit-review.json", commits)
    rows = ["# Current product inventory", "",
            f"Reviewed revision: `{report['revision']}`. Changes since `{data['baseline']}`: **{len(commits)} commits**.",
            "", "Every file has an owner. Text line counts include comments, tests and documentation; they are not executable LOC.",
            "", "| Product | Files | Text lines | Deliverable |", "|---|---:|---:|---|"]
    for product in data["products"]:
        files = [f for f in records if f["product"] == product["id"]]
        rows.append(f"| [{product['name']}](../{product['id']}.md) | {len(files)} | {sum(f['text_lines'] for f in files):,} | {product['deliverable']} |")
        card = [f"# {product['name']}", "", product["deliverable"] + ".", "",
                f"Audience: {product['audience']}.", "", "Source roots:", ""]
        card += [f"- `{root}`" for root in product["roots"]]
        card += ["", "Dependencies: " + (", ".join(product["dependencies"]) or "None declared") + ".",
                 "", "Package from the repository root:", "", "```powershell",
                 f"python scripts/product_suite.py bundle {product['id']}", "```", "",
                 "Release gates:", ""] + [f"- {gate}" for gate in product["gates"]]
        (ROOT / "products" / (product["id"] + ".md")).write_text("\n".join(card) + "\n", encoding="utf-8")
    rows += ["", f"Python syntax issues found: **{len(syntax_errors)}**. See `source-inventory.json` for paths and errors.", "",
             "Commit-to-product mapping: `commit-review.json`. Build/check outcomes: `checks.json` when generated."]
    (REPORTS / "INVENTORY.md").write_text("\n".join(rows) + "\n", encoding="utf-8")
    print(json.dumps({"files": len(records), "commits": len(commits),
                      "text_lines": sum(r["text_lines"] for r in records), "syntax_errors": syntax_errors}, indent=2))


def selected(data, product_id):
    by_id = {p["id"]: p for p in data["products"]}
    if product_id not in by_id:
        raise ValueError(f"Unknown product: {product_id}")
    result = set()
    def visit(key):
        if key in result:
            return
        result.add(key)
        for dep in by_id[key]["dependencies"]:
            visit(dep)
    visit(product_id)
    return result


def safe_to_bundle(path):
    parts = Path(path).parts
    return not (path.startswith((".continuity/", "data/", "products/reports/"))
                or any(p in {".env", "secrets", "credentials", ".secrets", ".local"} for p in parts)
                or Path(path).suffix.lower() in {".key", ".pem", ".p12", ".pfx", ".gguf", ".worm"})


def bundle(product_id):
    data = catalog()
    ids = selected(data, product_id)
    candidates = paths()
    included = {p for p in candidates if owner(p, data["products"]) in ids and safe_to_bundle(p)}
    # Preserve all available license declarations instead of choosing a blanket license.
    included.update(p for p in candidates if safe_to_bundle(p) and "LICENSE" in Path(p).name.upper())
    included.update({"products/catalog.json", "products/README.md", "scripts/product_suite.py"})
    included.update("products/" + p + ".md" for p in ids)
    manifest = {"product": product_id, "dependencies_included": sorted(ids - {product_id}),
                "revision": git("rev-parse", "HEAD").strip(), "policy": data["policy"], "files": []}
    destination = ROOT / "dist" / (product_id + ".zip")
    destination.parent.mkdir(exist_ok=True)
    if destination.exists():
        raise ValueError(f"Existing bundle preserved: {destination}; move it before rebuilding")
    fd, tmp = tempfile.mkstemp(prefix="product-", suffix=".zip", dir=destination.parent)
    os.close(fd)
    try:
        with zipfile.ZipFile(tmp, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6) as archive:
            for path in sorted(included):
                source = ROOT / path
                resolved = source.resolve()
                if not resolved.is_relative_to(ROOT) or source.is_symlink():
                    raise ValueError(f"Unsafe bundle path: {path}")
                raw = resolved.read_bytes()
                manifest["files"].append({"path": path, "sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw)})
                info = zipfile.ZipInfo(path, date_time=(2026, 1, 1, 0, 0, 0))
                info.compress_type = zipfile.ZIP_DEFLATED
                info.external_attr = 0o100644 << 16
                archive.writestr(info, raw)
            instructions = [f"# {product_id} source distribution", "", data["policy"], "",
                            "This archive preserves source paths. It has no Git metadata or installed dependencies.",
                            "Run the recipes below from the indicated directories after installing their toolchains.",
                            "The product_suite.py commands in product cards are for the full monorepo checkout.", ""]
            for product in data["products"]:
                if product["id"] not in ids:
                    continue
                instructions += ["## " + product["name"], ""]
                for recipe in product["checks"]:
                    instructions.append("- Directory `" + recipe["cwd"] + "`: `" +
                                        " ".join("python" if a == "{python}" else a for a in recipe["argv"]) + "`")
                instructions += ["", "Release gates:", ""] + ["- " + g for g in product["gates"]] + [""]
            raw = ("\n".join(instructions) + "\n").encode("utf-8")
            archive.writestr(zipfile.ZipInfo("BUNDLE-README.md", (2026, 1, 1, 0, 0, 0)), raw)
            manifest["files"].append({"path": "BUNDLE-README.md", "sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw)})
            archive.writestr(zipfile.ZipInfo("BUNDLE-MANIFEST.json", (2026, 1, 1, 0, 0, 0)),
                             json.dumps(manifest, indent=2) + "\n")
        os.replace(tmp, destination)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)
    print(json.dumps({"bundle": str(destination), "files": len(manifest["files"]), "bytes": destination.stat().st_size}))


def checks(product_id):
    data = catalog()
    products = [p for p in data["products"] if product_id == "all" or p["id"] in selected(data, product_id)]
    results = []
    env = dict(os.environ, CUDA_VISIBLE_DEVICES="", HIP_VISIBLE_DEVICES="", OMP_NUM_THREADS="1",
               OPENBLAS_NUM_THREADS="1", CARGO_BUILD_JOBS="1")
    for product in products:
        for recipe in product["checks"]:
            argv = [sys.executable if a == "{python}" else a for a in recipe["argv"]]
            start = time.monotonic()
            try:
                result = subprocess.run(argv, cwd=ROOT / recipe["cwd"], env=env, capture_output=True,
                                        text=True, encoding="utf-8", errors="replace", timeout=180)
                record = {"product": product["id"], "argv": recipe["argv"], "cwd": recipe["cwd"],
                          "status": "passed" if result.returncode == 0 else "failed",
                          "exit_code": result.returncode, "output": (result.stdout + result.stderr)[-12000:]}
            except (OSError, subprocess.TimeoutExpired) as exc:
                record = {"product": product["id"], "status": "blocked", "error": str(exc)}
            record["seconds"] = round(time.monotonic() - start, 3)
            results.append(record)
            print(product["id"] + ": " + record["status"], flush=True)
            write_json(REPORTS / "checks.json", {"revision": git("rev-parse", "HEAD").strip(), "checks": results,
                                                 "unchecked_products": [p["id"] for p in data["products"] if not p["checks"]]})
    return int(any(r["status"] != "passed" for r in results))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("inventory")
    sub.add_parser("list")
    for command in ("bundle", "check"):
        child = sub.add_parser(command)
        child.add_argument("product")
    args = parser.parse_args()
    if args.command == "inventory":
        inventory()
    elif args.command == "list":
        for product in catalog()["products"]:
            print(product["id"] + " — " + product["name"])
    elif args.command == "bundle":
        bundle(args.product)
    else:
        return checks(args.product)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
