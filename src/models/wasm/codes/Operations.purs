module Models.Wasm.Codes.Operations where

import Helpers.Types (Byte)

i32const ∷ Byte
i32const = 65

f32const ∷ Byte
f32const = 67

add ∷ Byte
add = 146

sub ∷ Byte
sub = 147

mul ∷ Byte
mul = 148

div ∷ Byte
div = 149

eq ∷ Byte
eq = 91

ne ∷ Byte
ne = 92

lt ∷ Byte
lt = 93

le ∷ Byte
le = 95

gt ∷ Byte
gt = 94

ge ∷ Byte
ge = 96
