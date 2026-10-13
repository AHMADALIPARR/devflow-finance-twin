# DevFlow product suite

This suite packages the current code into 23 source products with declared audiences, source ownership, dependencies, check recipes and release gates. The reviewed upstream revision is `1c187bb`; the old atlas at `289e058` is historical. The inventory and commit review are rebuilt from Git and source files, not copied from the old atlas.

Start with [the current inventory](reports/INVENTORY.md), [Build Your Own Bank](build-your-own-bank.md), or [the machine-readable catalog](catalog.json). Each product has a generated card beside this file. A source bundle preserves repository paths so its existing builds and imports remain understandable. Shared code is included through explicit dependencies. Shared platform support owns residual files; this is visible in the inventory rather than hidden by claiming everything is integrated.

```powershell
python scripts/product_suite.py list
python scripts/product_suite.py inventory
python scripts/product_suite.py bundle build-your-own-bank
python scripts/product_suite.py bundle tensor-core
```

Bundles are written to ignored `dist/`. They contain source, a SHA-256 manifest, product cards and existing license declarations. They exclude weights, credentials, continuity logs and runtime data. Existing bundles are preserved; move an earlier artifact before rebuilding. These are source distributions, not installed cross-language binaries. Dependencies and external compilers must be installed separately.

Run CPU checks using a small isolated environment:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install "pytest>=8,<9" pytest-asyncio
.\.venv\Scripts\python.exe scripts/product_suite.py check all
.\.venv\Scripts\python.exe products/bank_sandbox.py
```

The bank sandbox creates two accounts, transfers simulated funds, verifies the history and reloads it from a temporary ledger. It never connects to a payment rail. The original finance engine must pass the documented atomicity and security gates before serving real transactions. Run `products/bank_sandbox.py --probe-rejection` to reproduce the append-before-validation defect using disposable storage.

Checks report actual passed, failed and blocked outcomes. No GPU framework, local inference model or bot connection is started. Apple, CUDA/H100, HDL and prover validation remain separate platform jobs. Component tests establish their tested behavior; they do not establish cross-product integration, trained model quality, physical hardware, or banking readiness.

Existing per-file licenses remain authoritative. Conflicting source headers and package manifests require resolution before a uniform commercial release. This packaging change adds no licensing restrictions and removes none.
