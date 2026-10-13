# Audit and Archive Workbench

Go archive control, safety, sandbox and audit source modules.

Audience: Archive and evaluation tooling developers.

Source roots:

- `src/api.go`
- `src/acceptance-tests.go`
- `src/acceptance_test.go`
- `src/archive-extract-verify.go`
- `src/archive-tools.go`
- `src/audit-module.go`
- `src/audit-seal.go`
- `src/audit-verify.go`
- `src/control-dag.go`
- `src/control-policy.go`
- `src/gui-main.go`
- `src/main-app.go`
- `src/safety.go`
- `src/sandbox-boundary.go`
- `src/sandbox-module.go`
- `src/example_test.go`
- `src/example_abstention.go`
- `src/example_consistency_validator.go`
- `src/example_math_routing.go`

Dependencies: decision-classifier.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle audit-archive
```

Release gates:

- Multiple Go packages share src without a go.mod; repair build boundaries before shipping
- Evaluation specifications alone do not establish an executable evaluation product
