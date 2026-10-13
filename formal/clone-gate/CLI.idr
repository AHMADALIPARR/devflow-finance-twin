-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module CLI
import CloneGate.Files
import System
%default total
main : IO ()
main = do
  args <- getArgs
  case args of
    [_, "--challenge", challenge, "--key", key, "--expected", expected] => do
      result <- cloneGateEntry challenge key expected
      if result == 0 then exitSuccess else exitWith (ExitFailure result)
    _ => exitWith (ExitFailure 3)
