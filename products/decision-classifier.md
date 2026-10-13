<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Typed Decision SDK

Go decision envelopes, model routing, batch inference and audit library.

Audience: Decision system developers.

Source roots:

- `classifier`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle decision-classifier
```

Release gates:

- Verify actual backend and model behavior independently of README GPU claims
- Define calibrated model artifacts and evaluation datasets
- CPU backend ExecuteHeads currently returns fixed CLASS_A probabilities instead of a learned model
