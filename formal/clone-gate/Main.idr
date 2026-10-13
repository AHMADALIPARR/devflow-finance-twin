-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module Main
import CloneGate
import Data.Vect
import System
%default total

key : AESState
key = replicate 4 (replicate 4 0)

challenge : AESState
challenge = replicate 4 (replicate 4 0)

fingerprint : Fingerprint
fingerprint = flatten (decryptChallenge key challenge)

checks : Bool
checks = gateFlow (MkToken Valid fingerprint) key challenge == Just (replicate 4 0)
      && gateFlow (MkToken Trial fingerprint) key challenge == Nothing
      && gateFlow (MkToken Expired fingerprint) key challenge == Nothing
      && gateFlow (MkToken Valid (replicate 16 1)) key challenge == Nothing
      && gateFlow (MkToken Valid fingerprint) key (replicate 4 (replicate 4 1)) == Nothing

main : IO ()
main = if checks then putStrLn "clone-gate: checks passed" else exitFailure
