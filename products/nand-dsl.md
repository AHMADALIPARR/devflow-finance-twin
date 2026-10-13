# NAND DSL and Refinement Platform

NAND#, NAND ISA, binary formats, GFNAND parsing and refinement sources.

Audience: Compiler and binary semantics developers.

Source roots:

- `he-binary-functor/nand-architecture`
- `he-binary-functor/gfnand`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle nand-dsl
```

Release gates:

- Create executable parser/lowering and ISA conformance builds
- Validate refinement statements with pinned prover toolchains
