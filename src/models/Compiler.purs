module Models.Compiler where

import Data.Array (reverse)
import Models.Slots (Bytes, Skeleton)

type Compilation = {
  compiled ∷ Bytes,
  data ∷ Array Bytes,
  body ∷ Skeleton
}

compilation ∷ Array Bytes → Skeleton → Compilation
compilation b s = {compiled: [], data: reverse b, body: s}
