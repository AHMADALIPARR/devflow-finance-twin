<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Neural Model Lab

GLM Evoke, GGUF loaders, JAX, Pascal and Algol transformer sources.

Audience: Model architecture developers.

Source roots:

- `glm-evoke`
- `sovereign/glm`
- `src/jax_gpt_model.py`
- `src/jax_functional_transformer.py`
- `src/jax_transformer_harness.py`
- `src/jax_sequential_jacobian.py`
- `src/pascal`
- `src/a68`
- `src/agol86`
- `src/cuda`
- `src/jit_webllm_toy_transformer.js`
- `languages/apl`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle neural-model-lab
```

Release gates:

- No trained weights or architecture quality claims are implied
- Large frameworks and model loading are disabled in the low-memory workflow
- Each architecture needs compatible runtime, parity tests and model provenance
