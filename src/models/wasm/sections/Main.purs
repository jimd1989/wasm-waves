module Models.Wasm.Sections.Main where

import Helpers.Types (Bytes)
import Helpers.Unicode ((◇))
import Models.Wasm.Sections.Signatures (signatures)
import Models.Wasm.Sections.Code (code)
import Models.Wasm.Sections.FunctionTypes (functionTypes)
import Models.Wasm.Sections.Memory (memory)
import Models.Wasm.Sections.Globals (globals)
import Models.Wasm.Sections.Exports (exports)

wasm ∷ Bytes
wasm = [0, 97, 115, 109]

version ∷ Bytes
version = [1, 0, 0, 0]

header ∷ Bytes → Bytes
header α = wasm ◇ version ◇ signatures ◇ functionTypes ◇
           memory ◇ globals ◇ exports ◇ code α
