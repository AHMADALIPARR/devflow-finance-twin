<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Virtual H100 Architecture and Execution Models

H100/CUDA abstract-machine specifications and VSM H100 execution bridge.

Audience: GPU model and verification developers.

Source roots:

- `formal/formal-engine/GPU`
- `formal/formal-engine/GPU_H100.dfy`
- `vsm2500/vsm2500_h100_sass_bridge.cu`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle virtual-h100
```

Release gates:

- Validate instruction and memory-model conformance against an explicit target specification
- Run separate simulation, prover and real H100/CUDA jobs; an abstract model does not establish silicon execution
