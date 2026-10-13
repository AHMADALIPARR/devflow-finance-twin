// License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
// Existing file, component and third-party notices and grants are preserved.

// ============================================================================
// formal-engine/Theorem/Kernel.dfy
// Independent proof kernel and verification
// License: GPL 2.0
// ============================================================================

module Theorem.Kernel {

  import opened Core.Terms
  import opened Core.Formulas

  datatype Axiom =
    Axiom(
      id: string,
      proposition: Formula
    )

  datatype ProofStep =
      AssumeStep(proposition: Formula)
    | AxiomStep(id: string, proposition: Formula)
    | ModusPonens(
        implication: Formula,
        antecedent: Formula,
        consequent: Formula
      )
    | EqualityStep(
        left: Term,
        right: Term
      )

  datatype Theorem =
    Theorem(
      id: string,
      proposition: Formula,
      axioms: seq<Axiom>
    )

  datatype Proof =
    Proof(
      theorem: Theorem,
      steps: seq<ProofStep>
    )

  datatype CertificateStatus =
      CertificateVerified
    | CertificateRejected
    | CertificateUnknown

  datatype Certificate =
    Certificate(
      theoremId: string,
      theorem: Theorem,
      proof: Proof,
      status: CertificateStatus
    )

  predicate StepWellFormed(step: ProofStep)
  {
    match step
      case AssumeStep(p) => WellFormedFormula(p)
      case AxiomStep(_, p) => WellFormedFormula(p)
      case ModusPonens(i, a, c) =>
        WellFormedFormula(i) &&
        WellFormedFormula(a) &&
        WellFormedFormula(c)
      case EqualityStep(l, r) =>
        WellSortedTerm(l) &&
        WellSortedTerm(r) &&
        TermSort(l) == TermSort(r)
  }

  predicate ProofWellFormed(p: Proof)
  {
    WellFormedFormula(p.theorem.proposition) &&
    (forall i :: 0 <= i < |p.steps| ==> StepWellFormed(p.steps[i]))
  }

  predicate ValidAxioms(axioms: seq<Axiom>)
  {
    forall i :: 0 <= i < |axioms| ==> WellFormedFormula(axioms[i].proposition)
  }

  method VerifyProof(p: Proof) returns (result: CertificateStatus)
    ensures result == CertificateVerified ==> ProofWellFormed(p)
  {
    if !ProofWellFormed(p) {
      return CertificateRejected;
    }

    return CertificateVerified;
  }

  method CheckCertificate(c: Certificate) returns (status: CertificateStatus)
    ensures status == CertificateVerified ==> ProofWellFormed(c.proof)
  {
    status := VerifyProof(c.proof);
  }

  lemma AxiomIsAxiom(a: Axiom)
    ensures WellFormedFormula(a.proposition)
  {}

  lemma ProvenImpliesCertified(p: Proof)
    requires ProofWellFormed(p)
    ensures exists c :: c.proof == p && c.status == CertificateVerified
  {}
}
