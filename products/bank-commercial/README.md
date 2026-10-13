# Build Your Own Bank

Build Your Own Bank is a commercial product in development: a local treasury engine and integration kit for building financial software. This extracted workspace contains the Python engine, polyglot finance sources, constraint runtime, Go ledger dependency, tests, and original license notices.

The first installable deliverable is the CPU-only treasury CLI. It supports accounts, transfers, invoices, status and replay verification. Its money representation uses four decimal places. No inference model is loaded. The supporting COBOL, RPGLE, PL/I, C#, Scala, native and WASM components retain their independent build requirements.

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -e ".[dev]"
.\.venv\Scripts\byob-bank.exe --storage demo.worm CREATE_ACCOUNT --account_id treasury --balance 1000
.\.venv\Scripts\byob-bank.exe --storage demo.worm CREATE_ACCOUNT --account_id customer
.\.venv\Scripts\byob-bank.exe --storage demo.worm POST_TRANSACTION --tx_id demo-1 --from_account treasury --to_account customer --amount 125.50
.\.venv\Scripts\byob-bank.exe --storage demo.worm VERIFY_HISTORY
.\.venv\Scripts\python.exe -m pytest tests/test_stack.py tests/test_bank_commit.py -q
```

Commands now validate complete business rules on isolated state before append. Rejected commands and failed appends preserve live state, and commands on one engine instance are serialized. Duplicate transaction IDs and non-finite money are rejected. These checks do not establish cross-process transactional isolation.

This development kit is not yet a live bank or payment service. Actor names are caller-supplied labels, not authenticated identities. Read [COMMERCIAL_PLAN.md](COMMERCIAL_PLAN.md) for the customer deliverables, architecture boundaries and release requirements. The main project license is the Sovereign Leviathan mutated AGPLv3 covenant, SL-AGPL3-001. Existing component grants and contributor notices are preserved; commercial distribution scope and component exceptions remain recorded release requirements.
