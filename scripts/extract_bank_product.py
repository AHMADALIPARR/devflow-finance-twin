# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
"""Extract the bank source kit; preserve any locally edited workspace files."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--destination', required=True)
    args = parser.parse_args()
    destination = Path(args.destination).resolve()
    if destination == ROOT or not destination.is_relative_to(ROOT.parent):
        raise ValueError('Use a separate product directory within the workspace')
    archive_path = ROOT / 'dist/build-your-own-bank.zip'
    previous_path = destination / 'BUNDLE-MANIFEST.json'
    previous = {}
    if previous_path.exists():
        previous = {r['path']: r['sha256'] for r in json.loads(previous_path.read_text(encoding='utf-8'))['files']}
    receipt_path = destination / 'PRODUCT-EXTRACTION.json'
    prior_templates = json.loads(receipt_path.read_text(encoding='utf-8')).get('templates', {}) if receipt_path.exists() else {}
    templates = {}
    for name in ('pyproject.toml', 'README.md', 'COMMERCIAL_PLAN.md'):
        source = ROOT / 'products/bank-commercial' / name
        digest = hashlib.sha256(source.read_bytes()).hexdigest()
        target = destination / name
        if target.exists() and hashlib.sha256(target.read_bytes()).hexdigest() not in {digest, prior_templates.get(name)}:
            raise ValueError(f'Locally changed product template preserved: {target}')
        templates[name] = digest
    with zipfile.ZipFile(archive_path) as archive:
        manifest = json.loads(archive.read('BUNDLE-MANIFEST.json'))
        for record in manifest['files']:
            target = (destination / record['path']).resolve()
            if not target.is_relative_to(destination):
                raise ValueError('Archive path escapes product workspace')
            if target.exists():
                digest = hashlib.sha256(target.read_bytes()).hexdigest()
                if digest not in {previous.get(record['path']), record['sha256']}:
                    raise ValueError(f'Locally changed file preserved: {target}')
        # Validate every target before writing any source files.
        for record in manifest['files']:
            target = destination / record['path']
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(archive.read(record['path']))
        destination.mkdir(parents=True, exist_ok=True)
        previous_path.write_bytes(archive.read('BUNDLE-MANIFEST.json'))
    for name in ('pyproject.toml', 'README.md', 'COMMERCIAL_PLAN.md'):
        target = destination / name
        shutil.copyfile(ROOT / 'products/bank-commercial' / name, target)
    receipt_path.write_text(json.dumps({'templates': templates, 'source_archive': str(archive_path)}, indent=2)+'\n', encoding='utf-8')
    print(destination)


if __name__ == '__main__':
    main()
