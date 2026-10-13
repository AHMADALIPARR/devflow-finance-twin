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
