<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Tensor Core SDK

Rust tensors, views, reductions, broadcasting and linear algebra.

Audience: Numerical computing developers.

Source roots:

- `tensor-core/src`
- `tensor-core/examples`
- `tensor-core/Cargo.toml`
- `tensor-core/Cargo.lock`
- `tensor-core/README.md`
- `tensor-core/FORMAL_SPEC.md`
- `tensor-core/QUICKSTART.md`
- `tensor-core/STRUCTURE.md`
- `tensor-core/IMPLEMENTATION_NOTES.md`
- `tensor-core/COMPLETION_SUMMARY.md`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle tensor-core
```

Release gates:

- Validate ndarray version compatibility and optional BLAS toolchain
- Proof descriptions are not prover execution evidence
