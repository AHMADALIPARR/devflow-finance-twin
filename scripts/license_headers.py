# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# License-ID: SL-AGPL3-001 | Covenant-Version: 1.0
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
"""Audit/add references to existing licensing terms without relicensing files."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
LINE = {}
for extensions, prefix in [
    ('.py .sh .bash .ps1 .rb .ex .exs .toml .yaml .yml .r .R .bqn .jl .unl', '#'),
    ('.c .h .cpp .hpp .cc .cu .cuh .cs .go .rs .swift .metal .js .mjs .ts .java .scala .zig .dfy .d .v .sv .ptx', '//'),
    ('.hs .lhs .lean .sql .lua .occ .fut .vhd .vhdl', '--'),
    ('.pl .pro .lgt .ecl .erl .hrl .m', '%'),
    ('.asm .nasm', ';'), ('.wat .wast', ';;'), ('.rpgle', '//'),
    ('.f90 .f95', '!'), ('.cob .cbl', '      *>'), ('.apl', '⍝')]:
    for ext in extensions.split():
        LINE[ext] = prefix
BLOCK = {'.xml': ('<!--', '-->'), '.xsl': ('<!--', '-->'), '.xslt': ('<!--', '-->'),
         '.xsd': ('<!--', '-->'), '.html': ('<!--', '-->'), '.css': ('/*', '*/'),
         '.pas': ('{', '}'), '.sml': ('(*', '*)'), '.ml': ('(*', '*)'),
         '.mli': ('(*', '*)'), '.thy': ('(*', '*)'), '.s': ('/*', '*/'), '.S': ('/*', '*/'),
         '.fsl': ('<!--', '-->'), '.a68': ('#', '#'), '.mod': ('(*', '*)')}
MARKER = re.compile(r'SPDX-License-Identifier:|License-ID:|SOVEREIGN LEVIATHAN NODE LICENSE|'
                    r'licensed under|covered work under|License:\s*(?:MIT|Apache|AGPL|GPL|FSL)', re.I)
NOTICE = 'SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001\nLicensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.'


def insert_header(text, extension, path=''):
    newline = '\r\n' if '\r\n' in text else '\n'
    if path.endswith('go.mod'):
        header = '\n'.join('// ' + line for line in NOTICE.splitlines()) + '\n\n'
    elif extension in BLOCK:
        opening, closing = BLOCK[extension]
        header = opening + '\n' + NOTICE + '\n' + closing + '\n\n'
    else:
        prefix = LINE[extension]
        header = '\n'.join(prefix + ' ' + line for line in NOTICE.splitlines()) + '\n\n'
    header = header.replace('\n', newline)
    lines = text.splitlines(keepends=True)
    offset = 0
    if lines and (lines[0].startswith('#!') or lines[0].startswith('// swift-tools-version:')
                  or lines[0].strip().lower() == '**free'):
        offset = 1
    if extension == '.py':
        for i in range(min(2, len(lines))):
            if re.search(r'coding[:=]\s*[-\w.]+', lines[i]):
                offset = max(offset, i + 1)
    if text.startswith('<?xml'):
        end = text.find('?>') + 2
        return text[:end] + newline + header + text[end:].lstrip('\r\n')
    return ''.join(lines[:offset]) + header + ''.join(lines[offset:])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    files = subprocess.check_output(['git', 'ls-files', '-z', '--cached', '--others', '--exclude-standard'], cwd=ROOT).decode().split('\0')
    records = []
    for path in sorted(set(files) - {''}):
        source = ROOT / path
        extension = source.suffix
        if path.startswith(('products/reports/', 'LICENSES/')) or not source.is_file():
            continue
        if extension not in LINE and extension not in BLOCK:
            continue
        raw = source.read_bytes()
        if b'\0' in raw:
            continue
        try:
            text = raw.decode('utf-8-sig')
        except UnicodeDecodeError:
            records.append({'path': path, 'status': 'encoding-review-required'})
            continue
        if MARKER.search('\n'.join(text.splitlines()[:80])):
            records.append({'path': path, 'status': 'existing-notice-preserved'})
            continue
        record = {'path': path, 'status': 'header-added' if args.apply else 'missing-header',
                  'sha256_before': hashlib.sha256(raw).hexdigest(), 'license': 'LicenseRef-Sovereign-Leviathan-SL-AGPL3-001'}
        if args.apply:
            updated = insert_header(text, extension, path).encode('utf-8')
            if raw.startswith(b'\xef\xbb\xbf'):
                updated = b'\xef\xbb\xbf' + updated
            source.write_bytes(updated)
            record['sha256_after'] = hashlib.sha256(updated).hexdigest()
        records.append(record)
    destination = ROOT / 'products/reports/license-header-audit.json'
    destination.write_text(json.dumps({'policy': 'Preserve all existing grants and attribution; neutral references do not resolve conflicting scope.',
                                     'scope': 'Tracked and nonignored source files with supported comment syntax; binary, data and unsupported-language files are not edited.',
                                     'files': records}, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({status: sum(r['status'] == status for r in records) for status in sorted({r['status'] for r in records})}))


if __name__ == '__main__':
    main()
