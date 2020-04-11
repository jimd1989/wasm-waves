module Models.Wasm.Sections.Code where

import Prelude (join)
import Data.Array (cons)
import Data.Semigroup (append)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((∘))
import Models.Wasm.Codes.Types (f32, i32)
import Models.Wasm.Sections.Actions (withLength)

id ∷ Byte
id = 10

localFloats ∷ Bytes
localFloats = [1, f32]

localInts ∷ Bytes
localInts = [1, i32]

localVars ∷ Bytes
localVars = join [[2], localFloats, localInts]

code ∷ Bytes → Bytes
code = cons id ∘ withLength ∘ cons 1 ∘ withLength ∘ append localVars
