-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module Negative.Spent
import CloneGate
import Data.Vect
bad : (1 gate : CloneGate Spent) -> (Vect 4 Byte, CloneGate Spent)
bad gate = cloneGate gate
