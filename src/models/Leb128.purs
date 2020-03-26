module Models.Leb128 where

import Prelude ((<=))
import Data.Array ((:))
import Data.Int.Bits ((.&.), (.|.), shr)
import Models.Signatures (Bytes)

leb128 ∷ Int → Bytes
leb128 n = if next <= 0 then [byte] else (byte .|. 128) : (leb128 next)
  where
    next = shr n 7
    byte = n .&. 127
