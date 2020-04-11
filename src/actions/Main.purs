module Actions.Main where

import Math (tau)
import Foreign.Numbers (toBytes)
import Helpers.Types (Bytes)
import Helpers.Unicode ((◇))
import Models.Leb128 (leb128)
import Models.Wasm.Codes.Addresses (bufferLen, pitch, phase, n)
import Models.Wasm.Codes.Control (loop, brIf, end)
import Models.Wasm.Codes.Operations (i32const, f32const, i32add, i32ltu, 
                                     add, sub, div, mul, trunc)
import Models.Wasm.Codes.Memory (getGlobal, getLocal, setGlobal,
                                 setLocal, teeLocal, f32store, offset)
import Models.Wasm.Codes.Types (emptyBlock)

main' ∷ Bytes → Bytes
main' α = [getGlobal, phase,
           setLocal, phase,
           i32const] ◇ (leb128 0) ◇
          [setLocal, n,
           loop, emptyBlock,
           getLocal, n,
           getLocal, n,
           getLocal, phase,
           getLocal, pitch,
           add,
           f32const] ◇ (toBytes tau) ◇
          [div,
           teeLocal, phase,
           getLocal, phase,
           trunc,
           sub,
           f32const] ◇ (toBytes tau) ◇
          [mul,
           setLocal, phase] ◇
           α ◇
           -- stack should contain result of α(θ) and buffer position n now
          [f32store] ◇ offset ◇
          [i32const] ◇ (leb128 4) ◇
          [i32add,
           teeLocal, n,
           getGlobal, bufferLen,
           i32ltu,
           brIf] ◇ (leb128 0) ◇
          [end,
           getLocal, phase,
           setGlobal, phase,
           end]
