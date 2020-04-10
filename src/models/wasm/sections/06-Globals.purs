module Models.Wasm.Sections.Globals where

import Foreign.Numbers (toBytes)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((◇))
import Models.Wasm.Codes.Control (end)
import Models.Wasm.Codes.Operations (f32const)
import Models.Wasm.Codes.Types (f32)
import Models.Wasm.Sections.Actions (header)

id ∷ Byte
id = 6

immutable ∷ Byte
immutable = 0

mutable ∷ Byte
mutable = 1

phase ∷ Bytes
phase = [f32, mutable, f32const] ◇ (toBytes 0.0) ◇ [end]

globals ∷ Bytes
globals = header id [phase]
