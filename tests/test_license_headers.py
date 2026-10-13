# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
"""Ensure licensing comments preserve language declarations and source meaning."""
import ast
import importlib.util
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('license_headers', ROOT / 'scripts/license_headers.py')
headers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(headers)


def test_python_declarations_and_ast_are_preserved():
    source = '#!/usr/bin/env python3\n# coding: utf-8\n"""Module doc."""\nfrom __future__ import annotations\nx = "£"\n'
    result = headers.insert_header(source, '.py')
    assert result.startswith('#!/usr/bin/env python3\n# coding: utf-8\n')
    assert ast.dump(ast.parse(result)) == ast.dump(ast.parse(source))


def test_xml_fsl_header_preserves_parse_tree():
    source = '<?xml version="1.0"?>\n<fsl><invariant name="bounded" /></fsl>\n'
    result = headers.insert_header(source, '.fsl')
    assert result.startswith('<?xml version="1.0"?>')
    assert ET.tostring(ET.fromstring(result)) == ET.tostring(ET.fromstring(source))


def test_rpg_free_directive_stays_first():
    source = '**free\nctl-opt dftactgrp(*no);\n'
    result = headers.insert_header(source, '.rpgle')
    assert result.splitlines()[0] == '**free'
    assert result.splitlines()[1].startswith('// SPDX-License-Identifier:')
    assert '*> ' not in result


def test_wat_and_go_use_valid_comment_forms():
    assert headers.insert_header('(module)\n', '.wat').startswith(';; SPDX-License-Identifier:')
    assert headers.insert_header('module example\n', '.mod', 'go.mod').startswith('// SPDX-License-Identifier:')
