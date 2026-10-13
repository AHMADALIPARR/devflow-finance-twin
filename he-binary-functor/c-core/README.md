<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# c-core

**C Call Fibre** — C implementation of the call fibre supervisor.

## Files

| File | Language | Description |
|------|----------|-------------|
| `call_core.c` | C | Call fibre supervisor |

## Purpose

Supervises call fibres in the binary functor architecture, managing stack frames, continuations, and tail-call optimization.

## Build

```bash
gcc call_core.c -o call_core
```