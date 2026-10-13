<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Current product inventory

Reviewed revision: `1c187bbbd8e73ad60542f75b0db673ff2c3f6bb2`. Changes since `289e05876f15965a95f990ed178961aee0ebcb73`: **83 commits**.

Every file has an owner. Text line counts include comments, tests and documentation; they are not executable LOC.

| Product | Files | Text lines | Deliverable |
|---|---:|---:|---|
| [NAND DSL and Refinement Platform](../nand-dsl.md) | 23 | 2,002 | NAND#, NAND ISA, binary formats, GFNAND parsing and refinement sources |
| [FSL Formal Solver Kernel](../fsl-kernel.md) | 39 | 10,457 | Rust equality obligations, bit-vector/arithmetic IR, solver adapters and reactive proof modules |
| [OWL Constraint and AOT Harness](../owl-aot-harness.md) | 2 | 1,046 | RDF/Turtle parsing, OWL tableau constraints and bounded reasoning sources |
| [Astra Vault and Cryptographic Primitives](../astra-vault.md) | 16 | 2,063 | Astra math/Unlambda vault and RSL/braid/Yang-Baxter primitive sources |
| [Virtual H100 Architecture and Execution Models](../virtual-h100.md) | 4 | 2,438 | H100/CUDA abstract-machine specifications and VSM H100 execution bridge |
| [CUDA Kernel SDK](../cuda-kernels.md) | 11 | 2,950 | CUDA projection, softmax, vector and PTX launcher kernels |
| [Build Your Own Bank](../build-your-own-bank.md) | 64 | 12,291 | Commercial treasury development kit with installable CLI and polyglot integration sources |
| [Sovereign Ledger SDK](../sovereign-ledger.md) | 10 | 3,706 | Go hash-chain, event, snapshot and query library |
| [Constraint Runtime SDK](../constraint-runtime.md) | 41 | 2,042 | Python MXML contracts, Datalog constitution, DAG execution and audit seals |
| [Typed Decision SDK](../decision-classifier.md) | 14 | 5,393 | Go decision envelopes, model routing, batch inference and audit library |
| [Symbolic Reasoning Toolkit](../symbolic-reasoning.md) | 57 | 22,755 | ASP solver, Datalog sources and symbolic agent toolkit |
| [Dream-RSI Experiment Kit](../dream-rsi.md) | 37 | 2,064 | Python discovery, replay, evaluation, policy and simulator toolkit |
| [Tensor Core SDK](../tensor-core.md) | 19 | 4,339 | Rust tensors, views, reductions, broadcasting and linear algebra |
| [Governed Tensor SDK](../governed-tensor.md) | 13 | 2,976 | Rust virtual slicing, temporal safety, RAW_ROUTE and pure ML layer |
| [Apple Inference and Agent UX](../apple-inference.md) | 60 | 15,099 | Swift/Metal transformer, INT4 kernels, host interfaces and BEAM UX sources |
| [Apple Design Parser](../apple-design.md) | 11 | 5,936 | Swift HTML/CSS color, token and appearance extraction sources |
| [Neural Model Lab](../neural-model-lab.md) | 70 | 17,421 | GLM Evoke, GGUF loaders, JAX, Pascal and Algol transformer sources |
| [Formal Assurance Toolkit](../formal-assurance.md) | 126 | 14,772 | Dafny, Lean, CBMC and multi-prover specifications and harnesses |
| [Compiler and Binary Semantics Platform](../compiler-platform.md) | 243 | 33,152 | Cobalt, NAND/functor architecture, kernel language and polyglot toolchains |
| [Virtual Switchboard](../virtual-switchboard.md) | 4 | 6,966 | Python and x86 assembly routing, state machines and FFI sources |
| [Hardware and Semiconductor Kit](../hardware-design.md) | 24 | 13,160 | VHDL transformer RTL, SoC dossier, VSM2500 and GPU fabric sources |
| [Retro Compute Kit](../retro-compute.md) | 115 | 43,096 | 6502/x86 machine, Occam wordcode, JVM ISA and retro GPU simulators |
| [Quantum Simulation and Physics Lab](../quantum-simulation.md) | 73 | 13,412 | Python circuits, state vectors, noise, quantum compiler and physics sources |
| [Telegram Agent SDK](../telegram-agent-sdk.md) | 45 | 13,369 | Node, Rust and Haskell bots with persistence and agent adapters |
| [Workflow Workplace](../workflow-workplace.md) | 12 | 1,448 | Browser workplace, authentication helpers, coordinator and canvas templates |
| [Audit and Archive Workbench](../audit-archive.md) | 19 | 7,105 | Go archive control, safety, sandbox and audit source modules |
| [Verified Search Toolkit](../boyer-moore.md) | 5 | 1,196 | Boyer-Moore source and associated formal verification artifacts |
| [Lua RSI Runtime](../lua-rsi.md) | 23 | 6,798 | Lua experiment engine, codec and benchmark fixtures |
| [Shared Platform Support](../platform-support.md) | 275 | 109,168 | Repository documentation, licenses, orchestration scripts, configuration and remaining research artifacts |

Python syntax issues found: **3**. See `source-inventory.json` for paths and errors.

Commit-to-product mapping: `commit-review.json`. Build/check outcomes: `checks.json` when generated.
