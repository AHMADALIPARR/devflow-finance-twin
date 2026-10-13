"""Independently verify distributed source bytes and publish local receipts."""
import hashlib
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    data = json.loads((ROOT / "products/catalog.json").read_text(encoding="utf-8"))
    artifacts = []
    for product in data["products"]:
        path = ROOT / "dist" / (product["id"] + ".zip")
        with zipfile.ZipFile(path) as archive:
            manifest = json.loads(archive.read("BUNDLE-MANIFEST.json"))
            names = archive.namelist()
            assert len(names) == len(set(names)), path
            assert set(names) == {f["path"] for f in manifest["files"]} | {"BUNDLE-MANIFEST.json"}
            assert manifest["product"] == product["id"]
            for record in manifest["files"]:
                raw = archive.read(record["path"])
                assert hashlib.sha256(raw).hexdigest() == record["sha256"], record["path"]
                assert len(raw) == record["bytes"], record["path"]
                if record["path"] != "BUNDLE-README.md":
                    assert raw == (ROOT / record["path"]).read_bytes(), record["path"]
            artifacts.append({"product": product["id"], "artifact": path.name,
                              "bytes": path.stat().st_size, "files": len(manifest["files"]),
                              "sha256": hashlib.sha256(path.read_bytes()).hexdigest(), "integrity_verified": True})
    (ROOT / "products/reports/artifacts.json").write_text(json.dumps(artifacts, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"verified_artifacts": len(artifacts), "total_bytes": sum(a["bytes"] for a in artifacts)}))


if __name__ == "__main__":
    main()
