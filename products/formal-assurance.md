<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Formal Assurance Toolkit

Dafny, Lean, CBMC and multi-prover specifications and harnesses.

Audience: Verification engineers.

Source roots:

- `formal`
- `cbmc`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle formal-assurance
```

Release gates:

- Pin and execute each prover; separate axioms, bounded checks, placeholders and proven obligations
- Formal engine includes experimental cipher/ZK abstractions and structural proof checking
