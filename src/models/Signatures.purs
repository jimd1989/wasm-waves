module Models.Signatures where

import Prelude (class Show, ($), show)
import Data.Either (Either(..))
import Models.Parameters (ParameterCount(..))
import Models.Slots (Skeleton, Slot(..))

type Signature = {
  name ∷ String,
  args ∷ ParameterCount,
  body ∷ Skeleton
}

split ∷ Signature → Either Skeleton Skeleton
split {name: _, args: (Variadic _), body: x} = Right x
split {name: _, args: (Fixed    _), body: x} = Left x

signatures ∷ Array Signature
signatures = [
  {name: "f64", args: Fixed 1, body: [Full [68], Free]},
  {name: "+", args: Variadic 2, body: [Full [160]]},
  {name: "-", args: Variadic 2, body: [Full [161]]},
  {name: "*", args: Variadic 2, body: [Full [162]]},
  {name: "/", args: Variadic 2, body: [Full [163]]},
  {name: "=", args: Fixed 2, body: [Full [97], Free, Free]},
  {name: "!=", args: Fixed 2, body: [Full [98], Free, Free]},
  {name: "<", args: Fixed 2, body: [Full [99], Free, Free]},
  {name: ">", args: Fixed 2, body: [Full [100], Free, Free]},
  {name: "<=", args: Fixed 2, body: [Full [101], Free, Free]},
  {name: ">=", args: Fixed 2, body: [Full [102], Free, Free]}
] 
