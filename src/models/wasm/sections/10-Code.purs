module Models.Wasm.Sections.Code where

import Prelude (flip)
import Data.Array (cons, snoc)
import Data.Semigroup (append)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((∘))
import Models.Wasm.Codes.Control (end)
import Models.Wasm.Procedures.Memory (store)
import Models.Wasm.Sections.Actions (withLength)

id ∷ Byte
id = 10

-- Append a useless memory store operation before the body of the function
-- to test storage/access. Will be changed as full loop takes shape.
code ∷ Bytes → Bytes
code = cons id ∘ withLength ∘ cons 1 ∘ withLength ∘ cons 0 ∘
       append (store 4 1917.1917) ∘ flip snoc end
