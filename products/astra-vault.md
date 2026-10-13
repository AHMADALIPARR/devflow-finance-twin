<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Astra Vault and Cryptographic Primitives

Astra math/Unlambda vault and RSL/braid/Yang-Baxter primitive sources.

Audience: Cryptographic research and vault platform developers.

Source roots:

- `astre-vault/astra_math_vault.m`
- `astre-vault/astra-vault.unl`
- `he-binary-functor/crypto`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle astra-vault
```

Release gates:

- Define the Astra primitive algorithm, security properties and threat model; obtain independent cryptanalysis
- The OWL vault-close function reports entropy/consistency rather than a cryptographic commitment
- The existing seal chain uses FNV-1a-64; establish a cryptographically appropriate authenticated construction before security use
- Research novelty remains a contribution claim pending prior-art and comparative evidence
