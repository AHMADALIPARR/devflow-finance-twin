<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Dream-RSI Experiment Kit

Python discovery, replay, evaluation, policy and simulator toolkit.

Audience: Algorithm research teams.

Source roots:

- `dream_rsi`
- `tests/test_dream_rsi.py`
- `tests/test_dream_rsi_audit.py`
- `tests/test_dream_rsi_extensions.py`
- `tests/test_dream_rsi_full.py`
- `tests/test_dream_rsi_phase23.py`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle dream-rsi
```

Release gates:

- Reconstruction and replay scores require external-task evaluation before performance claims
- No automatic ledger write integration is established by packaging
