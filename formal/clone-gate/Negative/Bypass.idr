-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module Negative.Bypass
import CloneGate
-- Supplied bypass attempt. This fixture must fail: constructors are private.
masterKey : (k : Key256) -> (ct : State) -> (expected : Fingerprint) -> LicenseProof k ct expected
masterKey _ _ _ = Granted (believe_me Refl)
bypassMain : IO ()
bypassMain =
  let gate : EntryGate Attested
      gate = Unlocked
      proof : LicenseProof demoKey demoChallenge expectedFP
      proof = masterKey demoKey demoChallenge expectedFP
  in programMain proof gate
