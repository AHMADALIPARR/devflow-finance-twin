<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Verified Search Toolkit

Boyer-Moore source and associated formal verification artifacts.

Audience: Search and algorithm developers.

Source roots:

- `boyer-moore-unix`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle boyer-moore
```

Release gates:

- Run native search fixtures and verify associated proof obligations
