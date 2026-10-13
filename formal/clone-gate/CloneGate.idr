-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module CloneGate
import Data.Vect
import Data.Fin
import Data.Bits
import Decidable.Equality
%default total

public export
Byte : Type
Byte = Bits8
public export
Word : Type
Word = Vect 4 Byte
public export
State : Type
State = Vect 4 Word
public export
Key256 : Type
Key256 = Vect 32 Byte
public export
Fingerprint : Type
Fingerprint = State

-- Supplied 14-round toy: not the AES S-box, schedule or inverse cipher.
sbox : Byte -> Byte
sbox b = b + 1
rotL : Vect 4 a -> Vect 4 a
rotL [a, b, c, d] = [b, c, d, a]
rotVec : Vect (S n) a -> Vect (S n) a
rotVec (x :: xs) = snoc xs x
iterN : Nat -> (a -> a) -> a -> a
iterN Z _ x = x
iterN (S n) f x = iterN n f (f x)
take16 : Vect 32 a -> Vect 16 a
take16 = take 16
-- Data.Vect has no reshape in the pinned compiler; fix the size explicitly.
reshape : Vect 16 Byte -> State
reshape [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p] = [[a,b,c,d],[e,f,g,h],[i,j,k,l],[m,n,o,p]]
subBytes : State -> State
subBytes = map (map sbox)
shiftRows : State -> State
shiftRows [r0,r1,r2,r3] = [r0,rotL r1,rotL (rotL r2),rotL (rotL (rotL r3))]
addRoundKey : State -> State -> State
addRoundKey = zipWith (zipWith xor)
roundF : State -> State -> State
roundF k s = addRoundKey k (shiftRows (subBytes s))
deriveRoundKey : Key256 -> Fin 15 -> State
deriveRoundKey k r = reshape (take16 (iterN (finToNat r) rotVec k))
keySchedule : Key256 -> Vect 15 State
keySchedule k = tabulate (deriveRoundKey k)
export
encrypt : Key256 -> State -> State
encrypt k s =
  let rks = keySchedule k
      st0 = addRoundKey s (head rks)
  in foldl (\st, rk => roundF rk st) st0 (tail rks)
export
decrypt : Key256 -> State -> State
decrypt k = encrypt (Data.Vect.reverse k)

-- Abstract exported type; Granted is private to this module.
export
data LicenseProof : (k : Key256) -> (ct : State) -> (expected : Fingerprint) -> Type where
  Granted : (0 _ : decrypt k ct = expected) -> LicenseProof k ct expected
export
attest : (k : Key256) -> (ct : State) -> (expected : Fingerprint) -> Maybe (LicenseProof k ct expected)
attest k ct expected =
  case decEq (decrypt k ct) expected of
    Yes prf => Just (Granted prf)
    No _ => Nothing
public export
data GateState = Unattested | Attested
export
data EntryGate : GateState -> Type where
  Locked : EntryGate Unattested
  Unlocked : EntryGate Attested
export
newEntryGate : EntryGate Unattested
newEntryGate = Locked
export
attestGate : EntryGate Unattested -> (k : Key256) -> (ct : State) -> (expected : Fingerprint)
           -> Maybe (EntryGate Attested, LicenseProof k ct expected)
attestGate Locked k ct expected =
  case attest k ct expected of
    Nothing => Nothing
    Just prf => Just (Unlocked, prf)
public export
expectedFP : Fingerprint
expectedFP = replicate 4 (replicate 4 14)
export
programMain : {0 k : Key256} -> {0 ct : State}
           -> (0 _ : LicenseProof k ct expectedFP) -> EntryGate Attested -> IO ()
programMain _ _ = do
  putStrLn "==> Clone gate open."
  putStrLn "==> Executing guarded payload."
public export
demoKey : Key256
demoKey = replicate 32 0
public export
demoChallenge : State
demoChallenge = replicate 4 (replicate 4 0)
export
main : IO ()
main =
  case attestGate Locked demoKey demoChallenge expectedFP of
    Nothing => putStrLn "==> License check failed. Exiting."
    Just (gate, proof) => programMain proof gate
