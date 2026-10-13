# CUDA Kernel SDK

CUDA projection, softmax, vector and PTX launcher kernels.

Audience: GPU compute developers.

Source roots:

- `src/cuda`
- `gpu`
- `languages/ptx`

Dependencies: formal-assurance.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle cuda-kernels
```

Release gates:

- Pin CUDA toolkit and target architecture; run numerical parity, sanitizer, resource and performance jobs on supported hardware
