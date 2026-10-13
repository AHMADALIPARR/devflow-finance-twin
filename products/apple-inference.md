# Apple Inference and Agent UX

Swift/Metal transformer, INT4 kernels, host interfaces and BEAM UX sources.

Audience: Apple application developers.

Source roots:

- `apple-metal-inference`
- `metal`
- `beam`
- `asm`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle apple-inference
```

Release gates:

- Requires macOS and supported Apple GPU; no GPU test runs on this Windows host
- Validate tokenizer, weight conversion, decode quality, memory and kernel parity
