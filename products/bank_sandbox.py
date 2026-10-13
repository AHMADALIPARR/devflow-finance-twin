"""Disposable CPU-only treasury demonstration; original source licenses apply."""
import argparse
import json
from pathlib import Path
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from twin import FinanceTwinEngine
from worm import WormStorageEngine


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--probe-rejection", action="store_true")
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix="devflow-bank-") as folder:
        storage = WormStorageEngine(str(Path(folder) / "sandbox.worm"))
        bank = FinanceTwinEngine(storage)
        for account, balance in (("treasury", "1000.0000"), ("customer", "0.0000")):
            bank.execute_command("CREATE_ACCOUNT", "sandbox", {"account_id": account, "initial_balance": balance})
        if args.probe_rejection:
            before = storage.record_count()
            try:
                bank.execute_command("CREATE_ACCOUNT", "sandbox", {"account_id": "treasury", "initial_balance": "0"})
            except ValueError as exc:
                after = storage.record_count()
                replay_failed = False
                try:
                    FinanceTwinEngine(storage)
                except ValueError:
                    replay_failed = True
                print(json.dumps({"rejected": str(exc), "records_before": before, "records_after": after,
                                  "replay_failed": replay_failed, "release_blocker": after != before}, indent=2))
                # Report the observed gate without requiring the defect to persist.
                return 0
            raise RuntimeError("Duplicate account was not rejected")
        bank.execute_command("POST_TRANSACTION", "sandbox", {"transaction_id": "sandbox-transfer",
                             "from_account": "treasury", "to_account": "customer", "amount": "125.5000"})
        valid, error = bank.verify_ledger_consistency()
        restored = FinanceTwinEngine(storage)
        assert valid, error
        assert restored.list_accounts() == {"treasury": "874.5000", "customer": "125.5000"}
        assert restored.compute_state_hash() == bank.compute_state_hash()
        print(json.dumps({"product": "Build Your Own Bank", "mode": "local sandbox",
                          "accounts": restored.list_accounts(), "events": restored.event_count,
                          "history_verified": valid, "state_hash": restored.compute_state_hash()}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
