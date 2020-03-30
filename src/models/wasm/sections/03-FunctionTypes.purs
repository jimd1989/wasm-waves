module Models.Wasm.Sections.FunctionTypes where

import Helpers.Types (Byte, Bytes)
import Models.Wasm.Sections.Actions (header)

id ∷ Byte
id = 3

functionType ∷ Bytes
functionType = [0]

functionTypes ∷ Bytes
functionTypes = header id [functionType]
