module Models.Wasm.Procedures.Memory where

import Helpers.Types (Bytes)
import Helpers.Unicode ((◇))
import Foreign.Numbers (toBytes)
import Models.Leb128 (leb128)
import Models.Wasm.Codes.Operations (f32const, i32const)
import Models.Wasm.Codes.Memory (f32store)

type Address = Int

-- I still don't understand this tbh
offset ∷ Bytes
offset = [2, 0]

store ∷ Address → Number → Bytes
store α ω = [i32const] ◇ (leb128 α) ◇ [f32const] ◇
            (toBytes ω) ◇ [f32store] ◇ offset
