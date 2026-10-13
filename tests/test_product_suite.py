# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

"""Verify source distribution integrity and exclusion boundaries."""
import importlib.util
import json
from pathlib import Path
import zipfile
import hashlib

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("product_suite", ROOT / "scripts/product_suite.py")
suite = importlib.util.module_from_spec(spec)
spec.loader.exec_module(suite)


def test_all_source_paths_have_one_owner_and_valid_dependencies():
    data = suite.catalog()
    for path in suite.paths():
        assert suite.owner(path, data["products"])
    assert suite.selected(data, "build-your-own-bank") == {
        "build-your-own-bank", "sovereign-ledger", "constraint-runtime"}
    assert suite.owner("tensor-core/nraay-tensor/src/lib.rs", data["products"]) == "governed-tensor"


def test_runtime_and_credential_artifacts_are_excluded():
    for path in (".continuity/mcp-server.log", "data/treasury.bin", ".local/hf-token",
                 "secrets/token", "backend/.env", "models/a.gguf", "ledger.worm", "server.pem"):
        assert not suite.safe_to_bundle(path)
    assert suite.safe_to_bundle("finance/csharp/LedgerGateway.cs")


def test_bank_bundle_is_complete_and_bytes_match_manifest(tmp_path, monkeypatch):
    # A small fixture tests the real archive writer without copying the monorepo.
    (tmp_path / "products").mkdir()
    for name in ("README.md", "build-your-own-bank.md", "constraint-runtime.md", "sovereign-ledger.md"):
        (tmp_path / "products" / name).write_text("fixture\n", encoding="utf-8")
    (tmp_path / "scripts").mkdir()
    (tmp_path / "scripts/product_suite.py").write_text("fixture\n", encoding="utf-8")
    for root in ("finance", "ledger", "constraint", "data"):
        (tmp_path / root).mkdir()
        (tmp_path / root / "file.txt").write_text(root, encoding="utf-8")
    (tmp_path / "LICENSE").write_text("original terms", encoding="utf-8")
    data = {"policy": "preserve", "products": [
        {"id": "build-your-own-bank", "roots": ["finance"], "dependencies": ["constraint-runtime", "sovereign-ledger"]},
        {"id": "constraint-runtime", "roots": ["constraint"], "dependencies": []},
        {"id": "sovereign-ledger", "roots": ["ledger"], "dependencies": []},
        {"id": "platform-support", "roots": ["."], "dependencies": []}]}
    for product in data["products"]:
        product.update(name=product["id"], checks=[], gates=[])
    (tmp_path / "products/catalog.json").write_text(json.dumps(data), encoding="utf-8")
    monkeypatch.setattr(suite, "ROOT", tmp_path)
    monkeypatch.setattr(suite, "CATALOG", tmp_path / "products/catalog.json")
    monkeypatch.setattr(suite, "git", lambda *args: "abc123" if args[0] == "rev-parse" else
                        "\0".join(str(p.relative_to(tmp_path)).replace("\\", "/") for p in tmp_path.rglob("*") if p.is_file()))
    suite.bundle("build-your-own-bank")
    with zipfile.ZipFile(tmp_path / "dist/build-your-own-bank.zip") as archive:
        names = set(archive.namelist())
        assert {"finance/file.txt", "ledger/file.txt", "constraint/file.txt", "LICENSE"} <= names
        assert "data/file.txt" not in names
        manifest = json.loads(archive.read("BUNDLE-MANIFEST.json"))
        assert names == {f["path"] for f in manifest["files"]} | {"BUNDLE-MANIFEST.json"}
        for record in manifest["files"]:
            raw = archive.read(record["path"])
            assert hashlib.sha256(raw).hexdigest() == record["sha256"]
            assert len(raw) == record["bytes"]
