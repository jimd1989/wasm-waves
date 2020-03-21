module Models.Compiler where

import Models.Slots (Bytes, Skeleton)
import Models.Signatures (Signature)

type Compilation = {
  compiled ∷ Bytes,
  data ∷ Array Bytes,
  body ∷ Skeleton
}

compilation ∷ Array Bytes → Signature → Compilation
compilation b s = {compiled: [], data: b, body: s.body}
