# Symbolic Reasoning Toolkit

ASP solver, Datalog sources and symbolic agent toolkit.

Audience: Logic and constraint developers.

Source roots:

- `asp`
- `datalog-engine`
- `astre-vault`
- `src/souffle_symbolic_agent.py`
- `src/grounder.go`
- `src/ground_advanced.go`
- `src/ground_optimization.go`
- `src/substitution.go`
- `src/ir_types.go`
- `languages/prolog`
- `languages/logtalk`
- `languages/topos`
- `languages/lisp`
- `src/asp`
- `languages/eclipse`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle symbolic-reasoning
```

Release gates:

- Grounder and incremental Go files remain outside the asp module; integrate package boundaries
- Run solver correctness suites and supported Souffle/Prolog/Lisp toolchains
