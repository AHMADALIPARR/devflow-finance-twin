<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Sovereign Ledger SDK

Go hash-chain, event, snapshot and query library.

Audience: Event storage developers.

Source roots:

- `sovereign/ledger`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle sovereign-ledger
```

Release gates:

- Run Go tests and race checks; verify durable storage, snapshot recovery and cross-language contracts
