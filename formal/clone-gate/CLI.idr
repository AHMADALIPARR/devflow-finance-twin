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
      case result of
        0 => exitSuccess
        1 => exitWith (ExitFailure 1)
        2 => exitWith (ExitFailure 2)
        _ => exitWith (ExitFailure 3)
    _ => exitWith (ExitFailure 3)
