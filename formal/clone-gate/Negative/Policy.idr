-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module Negative.Policy
import CloneGate
import Data.Vect
bad : {0 k : Key256} -> {0 ct : State}
   -> (0 prf : LicenseProof k ct (replicate 4 (replicate 4 0)))
   -> EntryGate Attested -> IO ()
bad prf gate = programMain prf gate
