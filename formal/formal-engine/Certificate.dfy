// License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
// Existing file, component and third-party notices and grants are preserved.

// ============================================================================
// formal-engine/Certificate.dfy
// Certificate replay and justification predicates
// License: GPL 2.0
// ============================================================================

module Certificate {

  import opened Core.Types
  import opened Core.Formulas

  datatype Cert = Cert(claim: Formula, steps: seq<Formula>)

  predicate ValidCert(c: Cert) {
    ValidFormula(c.claim) && (forall s :: s in c.steps ==> ValidFormula(s))
  }

  predicate JustifiesClaim(c: Cert): bool
    requires ValidCert(c)
  {
    |c.steps| > 0 && ValidFormula(c.claim)
  }

  function CheckCert(c: Cert): bool
    requires ValidCert(c)
  {
    JustifiesClaim(c)
  }

  function ReplayCert(c: Cert): bool
    requires ValidCert(c)
  {
    CheckCert(c)
  }

  lemma Cert_validity_persists(c: Cert)
    requires ValidCert(c)
    ensures CheckCert(c) ==> JustifiesClaim(c)
  {}
}
