module Models.Leb128 where

import Prelude ((<=))
import Data.Array ((:))
import Data.Int.Bits ((.&.), (.|.), shr)
import Models.Signatures (Bytes)

leb128 ∷ Int → Bytes
leb128 n | n <= 0 = []
leb128 n          = (byte .|. 128) : (leb128 next) 
  where
    byte = n .&. 127
    next = shr n 7
