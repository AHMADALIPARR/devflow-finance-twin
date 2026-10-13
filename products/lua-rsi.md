<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Lua RSI Runtime

Lua experiment engine, codec and benchmark fixtures.

Audience: Embedded experiment developers.

Source roots:

- `lua`
- `benchmarks/rsi_lua`
- `tests/test_lua_engine.py`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle lua-rsi
```

Release gates:

- Run supported Lua runtime tests and compare benchmark provenance
