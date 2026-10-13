# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

"""Regression checks for rejected commands and failed storage commits."""
from decimal import Decimal
from concurrent.futures import ThreadPoolExecutor
import pytest
from twin import FinanceTwinEngine, quantize_money
from worm import WormStorageEngine, WormStorageError


@pytest.fixture
def bank(tmp_path):
    engine = FinanceTwinEngine(WormStorageEngine(str(tmp_path / "bank.worm")))
    engine.execute_command("CREATE_ACCOUNT", "test", {"account_id": "a", "initial_balance": "100"})
    engine.execute_command("CREATE_ACCOUNT", "test", {"account_id": "b", "initial_balance": "0"})
    return engine


@pytest.mark.parametrize("operation,data", [
    ("CREATE_ACCOUNT", {"account_id": "a", "initial_balance": "0"}),
    ("POST_TRANSACTION", {"transaction_id": "x", "from_account": "a", "to_account": "missing", "amount": "1"}),
    ("POST_TRANSACTION", {"transaction_id": "x", "from_account": "a", "to_account": "a", "amount": "1"}),
    ("REVERSE_TRANSACTION", {"transaction_id": "missing"}),
])
def test_rejections_preserve_history_and_replay(bank, operation, data):
    before = bank.storage.storage_path.read_bytes()
    state = bank.compute_state_hash()
    with pytest.raises(ValueError):
        bank.execute_command(operation, "test", data)
    assert bank.storage.storage_path.read_bytes() == before
    assert bank.compute_state_hash() == state
    assert FinanceTwinEngine(bank.storage).compute_state_hash() == state


def test_failed_append_preserves_live_state(bank, monkeypatch):
    before = bank.compute_state_hash()
    def fail(payload):
        raise WormStorageError("injected disk failure")
    monkeypatch.setattr(bank.storage, "append", fail)
    with pytest.raises(WormStorageError):
        bank.execute_command("CREATE_ACCOUNT", "test", {"account_id": "new", "initial_balance": "10"})
    assert bank.compute_state_hash() == before


def test_duplicate_transaction_does_not_debit_twice(bank):
    data = {"transaction_id": "x", "from_account": "a", "to_account": "b", "amount": "1"}
    bank.execute_command("POST_TRANSACTION", "test", data)
    with pytest.raises(ValueError):
        bank.execute_command("POST_TRANSACTION", "test", data)
    assert bank.accounts == {"a": Decimal("99.0000"), "b": Decimal("1.0000")}
    assert bank.storage.record_count() == 3


@pytest.mark.parametrize("amount", ["NaN", "Infinity", "-Infinity"])
def test_non_finite_money_rejected(amount):
    with pytest.raises(ValueError):
        quantize_money(amount)


def test_concurrent_commands_are_serialized(bank):
    def transfer(i):
        bank.execute_command("POST_TRANSACTION", "test", {"transaction_id": str(i),
                             "from_account": "a", "to_account": "b", "amount": "1"})
    with ThreadPoolExecutor(max_workers=4) as pool:
        list(pool.map(transfer, range(20)))
    assert bank.accounts == {"a": Decimal("80.0000"), "b": Decimal("20.0000")}
    assert bank.storage.record_count() == 22
    assert FinanceTwinEngine(bank.storage).compute_state_hash() == bank.compute_state_hash()
