<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# rust

**Rust Crates** — PWC (Provably Well-Constrained) verified crate with examples.

## Subdirectories

| Directory | Description |
|-----------|-------------|
| [pwc_verified/](pwc_verified/) | PWC verified crate |

## pwc_verified

| Subdirectory | Description |
|--------------|-------------|
| [src/](pwc_verified/src/) | Library source |
| [examples/](pwc_verified/examples/) | Usage examples |

## Build

```bash
cd pwc_verified && cargo build
cargo test
cargo run --example basic
```