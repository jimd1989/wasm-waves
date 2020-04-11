module Models.Wasm.Codes.Types where

import Helpers.Types (Byte)

exportFunction ∷ Byte
exportFunction = 0

exportMemory ∷ Byte
exportMemory = 2

exportGlobal ∷ Byte
exportGlobal = 3

function ∷ Byte
function = 96

f32 ∷ Byte
f32 = 125

i32 ∷ Byte
i32 = 127

emptyBlock ∷ Byte
emptyBlock = 64
