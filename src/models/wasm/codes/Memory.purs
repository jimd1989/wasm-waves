module Models.Wasm.Codes.Memory where

import Helpers.Types (Byte, Bytes)

getLocal ∷ Byte
getLocal = 32

setLocal ∷ Byte
setLocal = 33

teeLocal ∷ Byte
teeLocal = 34

getGlobal ∷ Byte
getGlobal = 35

setGlobal ∷ Byte
setGlobal = 36

f32load ∷ Byte
f32load = 42

f32store ∷ Byte
f32store = 56

-- Still don't understand this tbh; used when storing to an address
offset ∷ Bytes
offset = [2, 0]
