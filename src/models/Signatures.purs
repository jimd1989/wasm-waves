module Models.Signatures where

import Prelude (($), flip, join)
import Data.Bifunctor (bimap)
import Data.Either (Either)
import Data.Tuple (Tuple(..))
import Models.Parameters (ParameterCount(..), extract)

type Bytes = Array Int

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
  {name: "+", args: Variadic 2, slots: [], body: [[160]]},
  {name: "-", args: Variadic 2, slots: [], body: [[161]]},
  {name: "*", args: Variadic 2, slots: [], body: [[162]]},
  {name: "/", args: Variadic 2, slots: [], body: [[163]]},
  {name: "=", args: Fixed 2, slots: [0,1], body: [e,e,[97]]},
  {name: "!=", args: Fixed 2, slots: [0,1], body: [e,e,[98]]},
  {name: "<", args: Fixed 2, slots: [0,1], body: [e,e,[99]]},
  {name: ">", args: Fixed 2, slots: [0,1], body: [e,e,[100]]},
  {name: "<=", args: Fixed 2, slots: [0,1], body: [e,e,[101]]},
  {name: ">=", args: Fixed 2, slots: [0,1], body: [e,e,[102]]},
  {name: "?", args: Fixed 3, slots: [0,2,4], body: [e,[4,124],e,[5],e,[11]]} 
]
