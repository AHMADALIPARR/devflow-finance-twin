# Repository atlas

## Measured footprint

717 tracked files, 41 top-level directories and 22 root files; 103,552,555 Git blob bytes (98.76 MiB). Git-normalized content sizes exclude `.git`, history, generated builds and filesystem allocation. The README's historical 1,786-file claim does not describe this checkout. File extensions count artifacts, not independently validated languages or integrations.

The inventory observed 351 node-license markers in the first 5,000 bytes of files. This is a text-search result, not a complete legal scope map. No tracked model weight suffixes (`.gguf`, `.safetensors`, `.pt`, `.pth`, `.ckpt`), LFS pointers or symlinks were found.

## Working navigation

| Area | Starting point | Review boundary |
|---|---|---|
| Finance twin and audit storage | [src](../../src/), [tests](../../tests/) | Python fixture tests; live bank transport and production authorization not established |
| Legacy languages | [cobol](../../cobol/), [pli](../../pli/), [rpgle](../../rpgle/), [ada](../../ada/) | Separate native compiler acceptance required |
| Compiler and orchestration research | [cobalt-compiler](../../cobalt-compiler/), [constraint-harness](../../constraint-harness/), [isa-jvm](../../isa-jvm/), [rust/fsl](../../rust/fsl/) | Existence is distinct from successful builds |
| Mathematical and cryptographic research | [he-binary-functor](../../he-binary-functor/), [haskell](../../haskell/), [mathematics](../../mathematics/) | Research assumptions and attribution need claim-level review |
| Formal artifacts | [lean](../../lean/), [formal-token-verification](../../formal-token-verification/), [linear-algebra-verification](../../linear-algebra-verification/) | Placeholder reports, admissions and axioms prevent blanket proof claims |
| Quantum simulation | [quantum_computer](../../quantum_computer/) | Software simulator checks; no QPU execution established |
| Media and historical documents | [docs](../), [assets](../../assets/) | Preserve provenance and separate asset redistribution rights |

## Baseline directory counts

| Directory | Files | Git blob bytes |
|---|---:|---:|
| (root) | 22 | 203,187 |
| [ada](../../ada/) | 11 | 30,375 |
| [apl](../../apl/) | 3 | 51,549 |
| [assembly-120-strict-model](../../assembly-120-strict-model/) | 4 | 49,030 |
| [assets](../../assets/) | 10 | 178,726 |
| [astre-vault](../../astre-vault/) | 4 | 56,759 |
| [braid](../../braid/) | 1 | 703 |
| [chisel](../../chisel/) | 1 | 2,479 |
| [cobalt-compiler](../../cobalt-compiler/) | 28 | 183,343 |
| [cobol](../../cobol/) | 8 | 87,859 |
| [config-or-data](../../config-or-data/) | 1 | 15 |
| [config](../../config/) | 1 | 1,602 |
| [constraint-harness](../../constraint-harness/) | 41 | 72,052 |
| [csharp](../../csharp/) | 2 | 9,740 |
| [datalog-engine](../../datalog-engine/) | 12 | 17,806 |
| [docs](../../docs/) | 32 | 99,128,084 |
| [eclipse](../../eclipse/) | 1 | 18,857 |
| [examples](../../examples/) | 6 | 6,829 |
| [formal-token-verification](../../formal-token-verification/) | 25 | 57,899 |
| [formal-verification-paper](../../formal-verification-paper/) | 4 | 371,668 |
| [frontend](../../frontend/) | 2 | 17,702 |
| [haskell](../../haskell/) | 11 | 86,350 |
| [he-binary-functor](../../he-binary-functor/) | 199 | 600,833 |
| [isa-jvm](../../isa-jvm/) | 22 | 61,141 |
| [lean](../../lean/) | 15 | 137,744 |
| [linear-algebra-verification](../../linear-algebra-verification/) | 8 | 17,498 |
| [lisp](../../lisp/) | 2 | 34,612 |
| [logtalk](../../logtalk/) | 1 | 17,827 |
| [mathematics](../../mathematics/) | 1 | 692 |
| [pli](../../pli/) | 3 | 21,339 |
| [prolog](../../prolog/) | 1 | 1,679 |
| [ptx](../../ptx/) | 4 | 9,400 |
| [quantum_computer](../../quantum_computer/) | 26 | 347,260 |
| [rpgle](../../rpgle/) | 9 | 85,625 |
| [rust](../../rust/) | 37 | 300,993 |
| [scala](../../scala/) | 3 | 21,446 |
| [schema](../../schema/) | 2 | 4,566 |
| [scripts](../../scripts/) | 10 | 70,054 |
| [src](../../src/) | 126 | 1,076,784 |
| [tests](../../tests/) | 3 | 61,524 |
| [wasm](../../wasm/) | 12 | 34,018 |
| [x86_64](../../x86_64/) | 3 | 14,906 |

## Largest artifacts

| Path | Git blob bytes |
|---|---:|
| `docs/assets/demo-part7.mp4` | 28,680,567 |
| `docs/assets/demo-part5.mp4` | 23,154,020 |
| `docs/assets/hero-05.gif` | 10,887,980 |
| `docs/assets/demo-part1.mp4` | 10,816,943 |
| `docs/assets/hero-01.mp4` | 8,166,253 |
| `docs/assets/demo-part2.mp4` | 5,769,135 |
| `docs/assets/demo-part8.mp4` | 4,635,757 |
| `docs/assets/hero-04.png` | 2,489,605 |
| `docs/assets/demo-part3.mp4` | 2,082,424 |
| `docs/assets/demo-part4.mp4` | 1,332,880 |

Media dominate the footprint; this review does not remove, recompress or move them. Organization is navigational. The inventory retains each original path and checksum, including duplicates and empty files.

## Documentation gaps

Seven Markdown reports under `formal-token-verification/reports/` are empty. Its root specification/assumptions/theorem index and several other documents are also empty; all 15 empty files are enumerated in the inventory, including legitimate package `__init__.py` files. An empty report is not a successful verification run.

Examples observed during a scoped text review include `sorry` in `formal-token-verification/isabelle/TokenModel.thy` and `linear-algebra-verification/isabelle/LinearAlgebra.thy`, `admit()` in F* token models, and cryptographic assumptions declared as axioms in `lean/ZeroSorryCore.lean`. Text searches are triage rather than proof-checker executions. Templates and comments must be distinguished from executable proof holes in a subsequent theorem audit.
