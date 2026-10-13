<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Apple Design Parser

Swift HTML/CSS color, token and appearance extraction sources.

Audience: Design tooling developers.

Source roots:

- `apple-design-parser`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle apple-design
```

Release gates:

- Establish Swift build manifest and parser fixtures; benchmark on real designs
