# Prior art and attribution map

Reviewed 2026-10-07. This is a bounded technical literature review, not a patent search, freedom-to-operate finding or proof of originality. Sources establish precedents; they do not prove equivalence to every local construction. No competitor performance is inferred.

| Established topic / primary source | Local relationship | Candidate difference still needing evidence |
|---|---|---|
| [Bayer, Haber and Stornetta, Improving the Efficiency and Reliability of Digital Time-Stamping (1993)](https://www.math.columbia.edu/~bayer/papers/Timestamp_BHS93.pdf) | `src/worm.py` hash-linked event records | Workload integration and safeguards; hashing a log is established prior art |
| [RFC 2104: HMAC (1997)](https://www.rfc-editor.org/rfc/rfc2104.html) | Custom `he-binary-functor/crypto/iamac.rs` authentication research | Precise algorithm/threat-model difference and independent security analysis; no equivalence to HMAC established |
| [Ko et al., New Public-key Cryptosystem, CRYPTO 2000](https://www.iacr.org/archive/crypto2000/18800166/18800166.pdf) | Braid group cryptographic language in the README | A new name or Fibonacci combination does not establish a new secure cryptosystem |
| [Vazou et al., Refinement Types for Haskell, ICFP 2014](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/07/LiquidHaskell_ICFP14.pdf) | Workerman source explicitly attributes Liquid Haskell RefCore | Precisely specified extension semantics and verified implementation |
| [de Moura and Bjorner, Z3: An Efficient SMT Solver (2008)](https://www.microsoft.com/en-us/research/?p=825739) | FSL names a Z3 backend | Language/parser integration; successful backend execution and comparative usability/performance |
| [RFC 9162: Certificate Transparency v2 (2021)](https://www.rfc-editor.org/rfc/rfc9162.html) | Audit append-only integrity aspirations | Distinguish local hash chains from Merkle consistency proofs and signed external anchoring |
| [Martin Fowler, Event Sourcing](https://martinfowler.com/eaaDev/EventSourcing.html) | Replayable financial events | Explicit financial semantics, authorization and recoverability under failure |
| [Qiskit Aer simulator documentation](https://qiskit.github.io/qiskit-aer/stubs/qiskit_aer.AerSimulator.html) | Density matrix/noise simulator features | Specific supported models and numerical accuracy/scaling against a pinned baseline |

The [FBL research paper](../../he-binary-functor/fibonacci-braid-ledger/FBL_RESEARCH_PAPER.md) describes a bounded BQN/Liquid Haskell/RISC-V case study and explicitly disclaims production-ledger and cryptographic assumptions. Keep that narrower scope when describing the contribution. `word.c` in that directory performs adjacent inverse cancellation; it should not be described as establishing a complete braid-group normal form without handling the braid relations.

For a publication-grade review add dated search queries, publication identifiers, related-work alternatives, independent reviewers and a claim-to-result matrix. Patent novelty would require claim-specific analysis and appropriate professional review; none is asserted here.
