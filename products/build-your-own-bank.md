<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Build Your Own Bank

Commercial treasury development kit with installable CLI and polyglot integration sources.

Audience: Banking platform developers.

Source roots:

- `finance`
- `src/worm.py`
- `src/twin.py`
- `src/audit.py`
- `src/quantum.py`
- `src/cli.py`
- `src/native`
- `tests/test_stack.py`
- `schema`
- `languages/x86_64`
- `languages/chisel`
- `wasm`
- `build.zig`
- `Makefile`
- `scripts/compile_wasm.js`
- `products/bank_sandbox.py`
- `src/icp_anchor.py`
- `tests/test_cold_boot_icp.py`
- `tests/test_bank_commit.py`
- `products/bank-commercial`
- `scripts/extract_bank_product.py`

Dependencies: sovereign-ledger, constraint-runtime.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle build-your-own-bank
```

Release gates:

- Rejected commands and failed append isolation now pass regression tests; cross-process isolation remains required
- Cross-process locking, crash recovery, transaction idempotency, authentication and authorization need validation
- COBOL/RPGLE/PL-I/C#/Scala payment integrations require their own toolchains and end-to-end tests
- No live payment connection or bank deployment is packaged
