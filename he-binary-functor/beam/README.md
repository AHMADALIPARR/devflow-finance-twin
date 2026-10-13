<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# beam

**BEAM Assembly** — Erlang/BEAM call functor implementation.

## Files

| File | Language | Description |
|------|----------|-------------|
| `call_functor.erl` | Erlang | Call functor for BEAM VM |

## Purpose

Implements the call functor for the BEAM virtual machine, enabling interop between the binary functor architecture and Erlang processes.

## Build

```bash
erlc call_functor.erl
```