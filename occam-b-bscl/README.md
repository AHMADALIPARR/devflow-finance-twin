<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# occam-b-bscl — Wordcode Machine

A minimal compiler/runtime stack: **OCCAM + B + BSCL → common IR →
Wordcode → Wordcode Machine → native execution.** Not a small Java:
no objects, no GC, no class files, no JIT — words, registers, stacks,
processes, channels, deterministic scheduling.

## Build
    make # builds ./occamb
    make test # builds and runs the test suite

## CLI
    occamb build examples/factorial.b -o fact.wc
    occamb run fact.wc [--trace]
    occamb disassemble fact.wc
    occamb dump fact.wc
    occamb check examples/factorial.b
    occamb selftest

## Layout
See the source tree: `include/`, `src/`, `examples/`, `tests/`,
`docs/` (ARCHITECTURE.md, WORDCODE.md, MEMORY.md, CONCURRENCY.md).
