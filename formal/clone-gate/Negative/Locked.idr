-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module Negative.Locked
import CloneGate
import Data.Vect
bad : (1 gate : CloneGate Locked) -> (Vect 4 Byte, CloneGate Spent)
bad gate = cloneGate gate
