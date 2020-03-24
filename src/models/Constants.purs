module Models.Constants where

import Data.Array ((:))
import Math(e, pi, tau)
import Foreign.Numbers (toBytes)
import Models.Opcodes (f32const, getLocal)
import Models.Signatures (Bytes)

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
