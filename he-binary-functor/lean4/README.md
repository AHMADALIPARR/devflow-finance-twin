<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# lean4

**Lean 4 Formal Proofs** — Formal verification of NAND# architecture components.

## Files

| File | Description |
|------|-------------|
| `*.lean` | Lean 4 proof files |

## Purpose

Formal verification of:
- NAND# ISA correctness
- Refinement type soundness
- Bootstrap compiler properties

## Build

```bash
lake build
lake test
```