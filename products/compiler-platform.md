# Compiler and Binary Semantics Platform

Cobalt, NAND/functor architecture, kernel language and polyglot toolchains.

Audience: Language and compiler developers.

Source roots:

- `cobalt-compiler`
- `he-binary-functor`
- `kernel-language`
- `polyglot`
- `languages/braid`
- `languages/ada`
- `src/ebnf`
- `rust`
- `src/loader.ts`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle compiler-platform
```

Release gates:

- Define independent compiler builds and executable refinement fixtures
- Preserve per-component licenses; no blanket relicensing
