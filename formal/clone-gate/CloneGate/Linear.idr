-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module CloneGate.Linear

import Data.Vect
import Data.Bits
import Decidable.Equality

%default total

public export
Byte : Type
Byte = Bits8

public export
AESState : Type
AESState = Vect 4 (Vect 4 Byte)

public export
Fingerprint : Type
Fingerprint = Vect 16 Byte

-- The supplied toy transformation, not an AES implementation.
export
sbox : Byte -> Byte
sbox b = b + 1

export
subBytes : AESState -> AESState
subBytes = map (map sbox)

export
addRoundKey : AESState -> AESState -> AESState
addRoundKey = zipWith (zipWith xor)

export
aesRound : AESState -> AESState -> AESState
aesRound st k = addRoundKey (subBytes st) k

export
decryptChallenge : AESState -> AESState -> AESState
decryptChallenge k ct = addRoundKey ct k

export
flatten : AESState -> Fingerprint
flatten (r1 :: r2 :: r3 :: r4 :: Nil) = r1 ++ r2 ++ r3 ++ r4

export
verifyCrypto : Fingerprint -> AESState -> AESState -> Bool
verifyCrypto fp key challenge = flatten (decryptChallenge key challenge) == fp

public export
data LicenseStatus = Trial | Expired | Valid

-- Export the type, keeping its constructor inside this namespace.
export
data LicenseProof : LicenseStatus -> Type where
  ValidProof : LicenseProof Valid

-- Status is supplied by the caller; this prototype does not authenticate it.
public export
data LicenseToken : Type where
  MkToken : (status : LicenseStatus) -> (fp : Fingerprint) -> LicenseToken

noTrialValid : Trial = Valid -> Void
noTrialValid Refl impossible

noExpiredValid : Expired = Valid -> Void
noExpiredValid Refl impossible

noTrialExpired : Trial = Expired -> Void
noTrialExpired Refl impossible

decEqStatus : (a, b : LicenseStatus) -> Dec (a = b)
decEqStatus Trial Trial = Yes Refl
decEqStatus Trial Expired = No noTrialExpired
decEqStatus Trial Valid = No noTrialValid
decEqStatus Expired Trial = No (\eq => noTrialExpired (sym eq))
decEqStatus Expired Expired = Yes Refl
decEqStatus Expired Valid = No noExpiredValid
decEqStatus Valid Trial = No (\eq => noTrialValid (sym eq))
decEqStatus Valid Expired = No (\eq => noExpiredValid (sym eq))
decEqStatus Valid Valid = Yes Refl

public export
DecEq LicenseStatus where
  decEq = decEqStatus

export
decideLicense : LicenseToken -> AESState -> AESState -> Maybe (LicenseProof Valid)
decideLicense (MkToken Trial _) _ _ = Nothing
decideLicense (MkToken Expired _) _ _ = Nothing
decideLicense (MkToken Valid fp) key challenge =
  case verifyCrypto fp key challenge of
    True => Just ValidProof
    False => Nothing

public export
data GateState = Locked | Unlocked | Spent

export
data CloneGate : GateState -> Type where
  LockedGate : (gateId : Int) -> CloneGate Locked
  UnlockedGate : (gateId : Int) -> CloneGate Unlocked
  SpentGate : (gateId : Int) -> CloneGate Spent

export
newGate : Int -> CloneGate Locked
newGate = LockedGate

export
unlockGate : (0 _ : LicenseProof Valid) -> (1 g : CloneGate Locked) -> CloneGate Unlocked
unlockGate _ (LockedGate i) = UnlockedGate i

export
cloneGate : (1 g : CloneGate Unlocked) -> (Vect 4 Byte, CloneGate Spent)
cloneGate (UnlockedGate i) = (replicate 4 0, SpentGate i)

export
discardGate : (1 g : CloneGate Spent) -> ()
discardGate (SpentGate _) = ()

export
gateFlow : LicenseToken -> AESState -> AESState -> Maybe (Vect 4 Byte)
gateFlow token key challenge =
  case decideLicense token key challenge of
    Nothing => Nothing
    Just prf =>
      let gate = newGate 0
          unlocked = unlockGate prf gate
          (payload, spent) = cloneGate unlocked
      in case discardGate spent of
           () => Just payload

dummyKey : AESState
dummyKey = replicate 4 (replicate 4 0)

dummyChallenge : AESState
dummyChallenge = replicate 4 (replicate 4 0)

dummyFP : Fingerprint
dummyFP = flatten (decryptChallenge dummyKey dummyChallenge)

validToken : LicenseToken
validToken = MkToken Valid dummyFP

expiredToken : LicenseToken
expiredToken = MkToken Expired dummyFP

testValid : Maybe (Vect 4 Byte)
testValid = gateFlow validToken dummyKey dummyChallenge

testExpired : Maybe (Vect 4 Byte)
testExpired = gateFlow expiredToken dummyKey dummyChallenge
