module Models.Constants where

import Data.Array ((:))
import Math(e, pi, tau)
import Foreign.Numbers (toBytes)
import Helpers.Types (Bytes)
import Models.Wasm.Codes.Memory (getLocal)
import Models.Wasm.Codes.Operations (f32const)

type Constant = {
  name ∷ String,
  body ∷ Bytes
}

constants ∷ Array Constant
constants = [
  {name: "x", body: [getLocal, 0]},
  {name: "e", body: f32const : toBytes(e)},
  {name: "pi", body: f32const : toBytes(pi)},
  {name: "tau", body: f32const : toBytes(tau)}
]
