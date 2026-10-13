# Scrum charter and evidence backlog

## Scope and authority

The repository owner is the product and release authority. Codex acts as Scrum lead for this documentation assignment. Component maintainers, independent cryptographic reviewers and legal reviewers remain unassigned; no responsibilities or approvals are attributed to absent people. This repository is the working home for this assignment. The sibling Synthetic David repository is separate and is not silently imported.

Current increment: additive documentation only. Preserve every baseline file, path, source byte, license and media artifact. Implementation fixes, source reorganization, new scripts, licensing amendments and external publication belong to separately authorized increments. No deletion is proposed as a cleanup mechanism.

## Ordered backlog

| ID | Priority | Item | Acceptance evidence | Owner/status |
|---|---|---|---|---|
| GOV-01 | P0 | Reconcile artifact license scope and commercial permissions | Owner-approved rights matrix resolving root FSL, scoped AGPL, node headers and custom restrictions; preserve existing grants and third-party rights | Owner + legal reviewer; pending |
| COR-01 | P0 | Validate WORM append across newline platforms | Native Windows/POSIX tests retain all records and verify chain; compare controlled LF experiment; fix requires new scope | Component maintainer; pending |
| BUILD-01 | P1 | Resolve FSL test compilation | Pinned dependency/toolchain, `cargo test --locked` succeeds; actual four-backend results recorded separately | Rust maintainer; pending |
| PROOF-01 | P1 | Establish theorem evidence | Nonempty theorem manifest with checker versions, commands, outcomes and assumption/admission audit | Formal maintainers; pending |
| REL-01 | P1 | Identify and prepare Hugging Face target | Exact Hub URL/type/revision, effective license map, card, access settings and rights approval | Owner; target requested |
| SEC-01 | P1 | Review custom cryptographic claims | Threat models, algorithms, parameter bounds, test vectors and independent review; no security claims inferred from names | Independent reviewer; pending |
| CLAIM-01 | P1 | Qualify novelty statements | Contribution-by-contribution prior art, differences and reproducible evidence | Owner/research reviewers; draft register supplied |
| PERF-01 | P2 | Expand benchmark matrix | Controlled platforms, memory/scaling, correctness gates and comparable baselines | Maintainers; local WORM baseline supplied |
| DOC-01 | P2 | Navigable atlas and preservation manifest | Complete 717-path inventory and additions-only verification | Scrum lead; supplied in this increment |

## Cadence and acceptance

For each increment, record the source revision, objective, authorized paths, dependencies, owner and acceptance command before work. Review blocking evidence first; select a bounded backlog slice after dependencies are resolved. No fictional velocity, estimates, team assignments or retrospective meetings are recorded.

Definition of ready: bounded claim/workload, responsible owner, reproducible inputs, toolchain and legal scope identified. Definition of done: acceptance evidence attached; claims match actual results; source and artifact provenance recorded; license and security blockers explicitly dispositioned; permitted file scope verified. Documentation completion does not mark component correctness or release readiness complete.

An owner release review needs artifact hashes, source correspondence, rights chain, notices, card, benchmark results and unresolved issues. Payment terms and commercial agreements must identify actual covered artifacts and legal authority. Documentation does not itself add a payment gate or encryption mechanism.
