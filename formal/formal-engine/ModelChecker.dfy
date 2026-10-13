// License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
// Existing file, component and third-party notices and grants are preserved.

// ============================================================================
// formal-engine/ModelChecker.dfy
// Bounded model checking results
// License: GPL 2.0
// ============================================================================

module ModelChecker {

  import opened Core.Formulas

  datatype BMCRes =
    | WithinBound(depth: nat)
    | CexFound(trace: seq<Formula>)
    | Unk
    | Tmout

  predicate ValidBMCRes(r: BMCRes) {
    match r
    case WithinBound(_) => true
    case CexFound(tr) => forall f :: f in tr ==> ValidFormula(f)
    case Unk => true
    case Tmout => true
  }

  function ToVS(r: BMCRes): string
    requires ValidBMCRes(r)
  {
    match r
    case WithinBound(_) => "SAT_WITHIN_BOUND"
    case CexFound(_) => "COUNTEREXAMPLE"
    case Unk => "UNKNOWN"
    case Tmout => "TIMEOUT"
  }

  function Bounded(d: nat, f: Formula): BMCRes
    requires ValidFormula(f)
  {
    WithinBound(d)
  }

  lemma BMCRes_non_verified(r: BMCRes)
    requires ValidBMCRes(r)
    ensures ToVS(r) != "VERIFIED"
  {}
}
