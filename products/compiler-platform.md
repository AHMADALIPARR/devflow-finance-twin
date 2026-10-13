<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Compiler and Binary Semantics Platform

Cobalt, NAND/functor architecture, kernel language and polyglot toolchains.

Audience: Language and compiler developers.

Source roots:

- `cobalt-compiler`
- `he-binary-functor`
- `kernel-language`
- `polyglot`
- `languages/braid`
- `languages/ada`
- `src/ebnf`
- `rust`
- `src/loader.ts`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle compiler-platform
```

Release gates:

- Define independent compiler builds and executable refinement fixtures
- Preserve per-component licenses; no blanket relicensing
