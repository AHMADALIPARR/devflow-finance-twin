<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Virtual Switchboard

Python and x86 assembly routing, state machines and FFI sources.

Audience: Orchestration runtime developers.

Source roots:

- `src/virtual_switchboard.py`
- `src/switchboard_ffi.py`
- `src/switchboard_core.asm`
- `src/state_machine_core.asm`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle virtual-switchboard
```

Release gates:

- Build assembly library and verify ABI, rollback and bounded execution
- Self-improvement mechanisms require isolated evaluation
