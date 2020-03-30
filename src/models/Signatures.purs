module Models.Signatures where

import Prelude (($), flip, join)
import Data.Bifunctor (bimap)
import Data.Either (Either)
import Data.Tuple (Tuple(..))
import Helpers.Types (Bytes)
import Helpers.Unicode ((∘), (●))
import Models.Parameters (ParameterCount(..), extract)
import Models.Wasm.Codes.Control
import Models.Wasm.Codes.Operations
import Models.Wasm.Codes.Types (f32)

type Signature = {
  name ∷ String,
  args ∷ ParameterCount,
  slots ∷ Array Int,
  body ∷ Array Bytes
}

split ∷ Signature → Either (Tuple Int Signature) (Tuple Int Signature)
split s = join bimap (flip Tuple s) $ extract s.args

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
   body: [e, [if', f32], e, [else'], e, [end]]} 
]
