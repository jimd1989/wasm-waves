module Models.Procedure where

import Models.Bytes (Bytes(..))
import Models.Parameters (ParameterCount(..))

type ToCompile = {
  name ∷ String,
  data ∷ Array (Array Int)
}

type Signature = {
  name ∷ String,
  args ∷ ParameterCount,
  bytes ∷ Array Bytes
}

signatures ∷ Array Signature
signatures = [
  {name: "f64", args: Fixed 1, bytes: [Bytes [68], Slot]},
  {name: "+", args: Variadic 2, bytes: [Bytes [160]]},
  {name: "-", args: Variadic 2, bytes: [Bytes [161]]},
  {name: "*", args: Variadic 2, bytes: [Bytes [162]]},
  {name: "/", args: Variadic 2, bytes: [Bytes [163]]},
  {name: "=", args: Fixed 2, bytes: [Bytes [97], Slot, Slot]},
  {name: "!=", args: Fixed 2, bytes: [Bytes [98], Slot, Slot]},
  {name: "<", args: Fixed 2, bytes: [Bytes [99], Slot, Slot]},
  {name: ">", args: Fixed 2, bytes: [Bytes [100], Slot, Slot]},
  {name: "<=", args: Fixed 2, bytes: [Bytes [101], Slot, Slot]},
  {name: ">=", args: Fixed 2, bytes: [Bytes [102], Slot, Slot]}
] 
