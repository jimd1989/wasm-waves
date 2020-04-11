module Models.Wasm.Sections.Signatures where

import Helpers.Types (Byte, Bytes)
import Models.Wasm.Codes.Types (f32, function)
import Models.Wasm.Sections.Actions (header)

id ∷ Byte
id = 1

signature ∷ Bytes
signature = [function, 1, f32, 0]

signatures ∷ Bytes
signatures = header id [signature]
