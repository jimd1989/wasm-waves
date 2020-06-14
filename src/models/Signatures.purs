module Models.Signatures where

import Prelude (($), flip, join, negate)
import Data.Bifunctor (bimap)
import Data.Either (Either)
import Data.Tuple (Tuple(..))
import Math (pi)
import Foreign.Numbers (toBytes)
import Helpers.Types (Bytes)
import Models.Parameters (ParameterCount(..), extract)
import Models.Wasm.Codes.Addresses (rf1)
import Models.Wasm.Codes.Control (if', else', end)
import Models.Wasm.Codes.Memory (getLocal, teeLocal)
import Models.Wasm.Codes.Operations (f32const, add, div, eq, ge, gt, 
                                     le, lt, mul, ne,sub)
import Models.Wasm.Codes.Types (f32)

type Signature = {
  name ∷ String,
  args ∷ ParameterCount,
  slots ∷ Array Int,
  body ∷ Array Bytes
}

split ∷ Signature → Either (Tuple Int Signature) (Tuple Int Signature)
split α = join bimap (flip Tuple α) $ extract α.args

empty ∷ Bytes
empty = [0]

e ∷ Bytes
e = empty

signatures ∷ Array Signature
signatures = [
  {name: "+", args: Variadic 2, slots: [], body: [[add]]},
  {name: "-", args: Variadic 2, slots: [], body: [[sub]]},
  {name: "*", args: Variadic 2, slots: [], body: [[mul]]},
  {name: "/", args: Variadic 2, slots: [], body: [[div]]},
  {name: "=", args: Fixed 2, slots: [0,1], body: [e, e, [eq]]},
  {name: "!=", args: Fixed 2, slots: [0,1], body: [e, e, [ne]]},
  {name: "<", args: Fixed 2, slots: [0,1], body: [e, e, [lt]]},
  {name: ">", args: Fixed 2, slots: [0,1], body: [e, e, [gt]]},
  {name: "<=", args: Fixed 2, slots: [0,1], body: [e, e, [le]]},
  {name: ">=", args: Fixed 2, slots: [0,1], body: [e, e, [ge]]},
  {name: "?", args: Fixed 3, slots: [0,2,4],
   body: [e, [if', f32], e, [else'], e, [end]]},
  {name: "sin", args: Fixed 1, slots: [0],
   body: [e,
         [f32const], toBytes(pi),
         [sub,
          f32const], toBytes(0.318309886183791),
         [mul,
          teeLocal, rf1,
          getLocal, rf1,
          getLocal, rf1,
          getLocal, rf1,
          getLocal, rf1,
          f32const], toBytes(-1.66451778959003),
         [mul,
          mul,
          f32const], toBytes(4.74829052566064),
         [add,
          mul,
          mul,
          f32const], toBytes(-3.09012486790893),
         [add,
          mul]]}
]
