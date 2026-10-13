<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Retro Compute Kit

6502/x86 machine, Occam wordcode, JVM ISA and retro GPU simulators.

Audience: VM and systems language developers.

Source roots:

- `apple6502x86`
- `retro-gpu`
- `occam-b-bscl`
- `isa-jvm`
- `assembly-120-strict-model`
- `src/pcode_vm_full_stack.py`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle retro-compute
```

Release gates:

- Pin each assembler/compiler and provide machine conformance fixtures
