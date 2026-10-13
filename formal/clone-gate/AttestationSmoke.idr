-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module AttestationSmoke
import CloneGate
import Data.Vect
import System
%default total
hasProof : Maybe a -> Bool
hasProof Nothing = False
hasProof (Just _) = True
checks : Bool
checks = hasProof (attest demoKey demoChallenge expectedFP)
      && not (hasProof (attest demoKey demoChallenge (replicate 4 (replicate 4 0))))
      && not (hasProof (attest demoKey (replicate 4 (replicate 4 1)) expectedFP))
main : IO ()
main = if checks then putStrLn "attestation: checks passed" else exitFailure
