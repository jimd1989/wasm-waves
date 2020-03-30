module Models.Leb128 where

import Data.Array ((:))
import Data.Int.Bits ((.&.), (.|.), shr)
import Helpers.Types (Bytes)
import Helpers.Unicode ((≤))

leb128 ∷ Int → Bytes
leb128 α = if next ≤ 0 then [byte] else (byte .|. 128) : (leb128 next)
  where
    next = shr α 7
    byte = α .&. 127
