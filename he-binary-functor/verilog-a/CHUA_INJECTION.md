<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Chua's Circuit Injection into zeta_unfold_node

## 1. Inject Chua's Double-Scroll Topology
**Nonlinear Admittance**

Replace the static logarithmic dispersion of zeta_unfold_node with a piecewise-linear Chua's diode characteristic:
```
f(v) = m_1 v + ½(m_0 - m_1)(|v + 1| - |v - 1|)
```
This introduces the structural bifurcation required to transition from a single-point attractor to deterministic chaos.

## 2. Construct the Recursive Functor Offset
**Functorial Deformation**

Define a non-stationary functor F_t : CIRCUIT → QARRAY where the mapping injects a time-dependent shift parameter Δτ. This shatters the conjectured continuous-time functoriality, proving that continuous-time operator composition fails without explicit state-space discretization offsets.

## 3. Burst the Conjectured Functoriality
**Topological Rupture**

Enforce the Jacobian determinant condition J ≠ 1 across the differential manifold. Because Chua's circuit exhibits continuous expansion and contraction in phase space (dissipative chaos), the volume form collapses exponentially, proving that no smooth functorial equivalence can exist between the continuous Verilog-A semantics and a stationary finite quantum array.