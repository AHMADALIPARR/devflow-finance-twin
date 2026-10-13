# FSL Formal Solver Kernel

Rust equality obligations, bit-vector/arithmetic IR, solver adapters and reactive proof modules.

Audience: Constraint compiler developers.

Source roots:

- `rust/fsl`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle fsl-kernel
```

Release gates:

- Compile and execute library fixtures; distinguish solver adapters from external solver execution
- Library check passes, but unit tests cannot compile because jitter_machine is referenced without a module or dependency
