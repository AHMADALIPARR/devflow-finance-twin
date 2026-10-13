# Build Your Own Bank

Local treasury sandbox and polyglot integration source kit.

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

Dependencies: sovereign-ledger, constraint-runtime.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle build-your-own-bank
```

Release gates:

- Rejected operations currently append before complete business validation in src/twin.py; atomic validation and commit are required
- Cross-process locking, crash recovery, transaction idempotency, authentication and authorization need validation
- COBOL/RPGLE/PL-I/C#/Scala payment integrations require their own toolchains and end-to-end tests
- No live payment connection or bank deployment is packaged
