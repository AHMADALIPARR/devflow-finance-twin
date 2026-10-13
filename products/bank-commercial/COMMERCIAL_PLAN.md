# Commercial product plan

Product: Build Your Own Bank. Initial buyer: financial software teams needing an extensible treasury development kit. First deliverable: installable local treasury engine with documented source adapters. Later customer deliverables: authenticated bank-builder workspace, policy configuration, account and payment operations, reconciliation and auditable reporting.

| Layer | Current deliverable | Required before hosted pilot |
|---|---|---|
| Treasury | Account, transfer, invoice, status and replay CLI; rejection/write-failure regression tests | Durable cross-process transaction boundary, complete state hashing and journal verification, authenticated roles, transaction retry semantics |
| Policies | Extracted MXML constraint runtime | Enforced finance command contracts, real provider adapters, tenant-specific policy tests |
| Event storage | Python hash-chain log and separate Go ledger sources | Pick and integrate one authoritative store; crash recovery, migration and restore drills; bounded memory append |
| Payment adapters | COBOL/RPGLE/PL-I/C#/Scala sources | Buildable contracts, provider sandbox credentials, end-to-end acknowledgements and reconciliation |
| Customer application | Product definition and CLI | Tenant onboarding, account dashboard, approval workflows, operational alerts and support tooling |
| Commercial distribution | Original source notices and header audit | Path-level contributor/third-party rights determination, approved commercial terms, component SBOM and corresponding-source handling |

The neural, symbolic and hardware components remain optional research or integration products. A neural model must not bypass deterministic treasury validation or receive automatic authority to move money. A proposed connection between components is not an implemented integration.

Acceptance for an internal pilot: rejected operations leave durable history unchanged; failed writes leave live state unchanged; concurrent commands on one instance preserve balances; duplicate transaction IDs do not debit twice; monetary values must be finite; persisted state reloads exactly. These are implemented checks in `tests/test_bank_commit.py` and the existing finance tests.

Acceptance for a hosted commercial pilot additionally requires the outstanding items in the table, verified buildable adapters, and a concrete jurisdiction/payment-provider deployment plan. No live payment provider, hosted deployment, proprietary-license substitution or claimed banking authorization is part of this extraction.
