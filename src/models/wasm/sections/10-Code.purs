module Models.Wasm.Sections.Code where

import Prelude (flip)
import Data.Array (cons, snoc)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((∘))
import Models.Wasm.Codes.Control (end)
import Models.Wasm.Sections.Actions (withLength)

id ∷ Byte
id = 10

code ∷ Bytes → Bytes
code = cons id ∘ withLength ∘ cons 1 ∘ withLength ∘ cons 0 ∘ flip snoc end
