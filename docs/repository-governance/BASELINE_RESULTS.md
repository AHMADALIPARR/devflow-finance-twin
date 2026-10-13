# Executed baseline: 2026-10-07

Source: `289e05876f15965a95f990ed178961aee0ebcb73`. Host: Windows 10 Home 10.0.19041; Intel Core i7-8565U, 4 cores / 8 logical processors; approximately 7.92 GiB visible RAM; Python 3.12.10. This is a local development baseline, not an independent certification or production load test.

## Correctness outcomes

| Executed suite | Actual outcome | Scope |
|---|---|---|
| `python -B -m unittest discover -s tests -v` | 122 tests passed; initial runner time 27.149 s; transcript capture run 12.174 s | Local finance/audit/cold-boot fixtures; no real customer transactions |
| `quantum_computer/tests/test_full.py` | 408 passed, 0 failed | Script checks, not independently enumerated pytest cases |
| `quantum_computer/tests/test_simulator.py` | 68 passed, 1 failed: `sv_bell_measure` | Measurement return-format membership assertion at line 105; failure not repaired or excluded |
| `quantum_computer/tests/test_extended.py` | 189 passed, 0 failed | Software simulator fixture checks |
| FSL `cargo test --manifest-path rust/fsl/Cargo.toml --locked --target-dir <external-temp-path>` | Compilation failed, E0432 unresolved import `jitter_machine`, `src/lib.rs` lines 932, 941, 960 | Rust 1.99 GNU; tests did not run |
| Controlled LF append experiment | Expected 2 records; observed 1; integrity failed | Windows fixture with LF text-write behavior; not native POSIX execution |

The quantum scripts collectively report 665 passing checks and one failing check; this is not a repository-wide proof score. Finance tests and simulator checks overlap in features and are not interchangeable units. Constraint-harness pytest, native language toolchains, formal checkers, GPU kernels and other Rust crates were not validated in this baseline. The global Python environment lacked pytest; no dependencies were installed into this repository.

The [finance transcript](finance-unittest-evidence.md) and simulator transcript files in this directory preserve runner output.

## WORM timings

Synthetic local filesystem benchmark with one warmup plus five measured trials per size. Append timing includes `fsync`; every retained Windows trial preserved the expected count and valid chain. Raw per-trial results are in [benchmark-results.json](benchmark-results.json); protocol and driver are in [benchmark protocol](BENCHMARK_PROTOCOL.md).

| Records/trial | Median total append ms | Trial total range ms | Median of trial call medians ms | Median of trial p95s ms | Valid trials |
|---|---:|---:|---:|---:|---:|
| 100 | 2913.074 | 1711.359Ã¢â‚¬â€œ4478.267 | 18.921 | 87.763 | 5/5 |
| 250 | 9379.759 | 7450.440Ã¢â‚¬â€œ10865.258 | 23.953 | 126.218 | 5/5 |

The columns aggregate per-trial statistics; the median of p95s is not a pooled p95. Growing-file reads/rewrites and storage flushes are included. Uncontrolled host activity, no cache reset and a single platform limit interpretation. There is no comparison with a commercial system or cryptographic performance baseline.

## Blocking findings

**COR-01:** `src/worm.py` checks whether a temporary file containing the new record is larger than its LF-encoded size before retaining existing content. Windows CRLF translation made that branch execute in the default tests. In the controlled LF experiment it did not; replacement retained only the second record, whose predecessor hash no longer existed. This is a reproducible local counterexample to an unconditional append-preservation claim. Native POSIX validation and an authorized code fix are separate work.

**BUILD-01:** FSL tests do not compile with the checked-in dependency declarations. No four-backend success is reported.

**PROOF-01:** The seven token verification report Markdown files are zero-byte placeholders. Observed admissions and axioms also require theorem-level qualification; no proof checker was run.

**SEC-01:** Local hash seals do not alone establish authenticated identity, nonrepudiation or external anchoring. The finance test named concurrent appends executes a sequential loop, so its pass does not establish concurrent-writer safety. Quantum finance suggestions in `src/quantum.py` do not establish a physical QPU or numerical optimizer. These findings describe evidence scope, not an exhaustive security audit.

Source was left unchanged. License conflicts remain separately recorded in [license governance](LICENSE_GOVERNANCE.md).
