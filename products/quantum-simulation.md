<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Quantum Simulation and Physics Lab

Python circuits, state vectors, noise, quantum compiler and physics sources.

Audience: Simulation researchers.

Source roots:

- `quantum_computer`
- `qflow`
- `physics`
- `haskell`
- `languages/futhark`
- `languages/mathematics`
- `src/oscillator_fixedpoints.py`
- `src/nct_resonance_simulator.py`
- `src/omega_jax_pivot.py`
- `src/simulate_gate_list.py`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle quantum-simulation
```

Release gates:

- Simulation results do not establish physical quantum hardware or claimed novel physics
- Haskell/MATLAB/Julia/Isabelle paths need independent toolchains
- Existing quantum test files execute at import and call sys.exit; run them as bounded standalone jobs, not pytest collection
