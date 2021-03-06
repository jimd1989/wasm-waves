module Models.Wasm.Sections.Globals where

import Foreign.Numbers (toBytes)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((◇))
import Models.Leb128 (leb128)
import Models.Wasm.Codes.Control (end)
import Models.Wasm.Codes.Operations (f32const, i32const)
import Models.Wasm.Codes.Types (f32, i32)
import Models.Wasm.Sections.Actions (header)

id ∷ Byte
id = 6

immutable ∷ Byte
immutable = 0

mutable ∷ Byte
mutable = 1

bufferLen ∷ Bytes
bufferLen = [i32, immutable, i32const] ◇ (leb128 3840) ◇ [end]

phase ∷ Bytes
phase = [f32, mutable, f32const] ◇ (toBytes 0.0) ◇ [end]

globals ∷ Bytes
globals = header id [bufferLen, phase]
