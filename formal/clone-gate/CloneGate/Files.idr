-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
module CloneGate.Files
import CloneGate
import Data.Buffer
import Data.Vect
import System.File
import System.File.Buffer
%default total

readVector : Buffer -> (n : Nat) -> Int -> IO (Vect n Byte)
readVector buf Z offset = pure []
readVector buf (S n) offset = do
  value <- getByte buf offset
  rest <- readVector buf n (offset + 1)
  pure (cast value :: rest)

export
readBytesAt : String -> (n : Nat) -> IO (Either String (Vect n Byte))
readBytesAt path n = do
  Right handle <- openFile path Read
    | Left err => pure (Left (show err))
  Right size <- fileSize handle
    | Left err => do closeFile handle; pure (Left (show err))
  case size == cast n of
    False => do
      closeFile handle
      pure (Left "Invalid binary length")
    True => do
      Just buf <- newBuffer size
        | Nothing => do closeFile handle; pure (Left "Buffer allocation failed")
      result <- readBufferData handle buf 0 size
      closeFile handle
      case result of
        Left err => pure (Left (show err))
        Right count => case count == size of
          False => pure (Left "Truncated binary input")
          True => do
            bytes <- readVector buf n 0
            pure (Right bytes)

hexValue : Char -> Maybe Byte
hexValue c =
  if c >= '0' && c <= '9' then Just (cast (ord c - ord '0'))
  else if c >= 'a' && c <= 'f' then Just (cast (ord c - ord 'a' + 10))
  else if c >= 'A' && c <= 'F' then Just (cast (ord c - ord 'A' + 10))
  else Nothing

hexBytes : List Char -> Maybe (List Byte)
hexBytes [] = Just []
hexBytes [_] = Nothing
hexBytes (hi :: lo :: rest) = do
  h <- hexValue hi
  l <- hexValue lo
  tail <- hexBytes rest
  pure ((h * 16 + l) :: tail)

export
parseHex16 : String -> Maybe Fingerprint
parseHex16 text = do
  bytes <- hexBytes (unpack text)
  fixed <- toVect 16 bytes
  pure (reshape fixed)

export
cloneGateEntry : String -> String -> String -> IO Int
cloneGateEntry challengePath keyPath expectedHex =
  case parseHex16 expectedHex of
    Nothing => pure 3
    Just expected =>
      if expected /= expectedFP then pure 3 else do
        Right ct <- readBytesAt challengePath 16
          | Left _ => pure 2
        Right key <- readBytesAt keyPath 32
          | Left _ => pure 2
        case attestGate newEntryGate key (reshape ct) expectedFP of
          Nothing => pure 1
          Just (gate, prf) => do programMain prf gate; pure 0
