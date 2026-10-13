<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# OWL Constraint and AOT Harness

RDF/Turtle parsing, OWL tableau constraints and bounded reasoning sources.

Audience: Ontology and ahead-of-time constraint developers.

Source roots:

- `astre-vault/astra_owl_solver.py`
- `astre-vault/rcc8_spatial.py`

Dependencies: constraint-runtime.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle owl-aot-harness
```

Release gates:

- Locate and verify the owner-described AOT compiler entry point; current inspected entry point is tableau reasoning
- Pin RDF dependencies and add ontology conformance and contradiction fixtures
- A zero exit status for the demo is execution evidence, not proof of semantic correctness
