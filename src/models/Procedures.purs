module Models.Procedures where

import Prelude (class Show, ($), show)
import Models.Parameters (ParameterCount(..))

data Slot = Slot | Bytes (Array Int)

type Bytes = Array Int

bytes ∷ Slot → Bytes
bytes  Slot      = []
bytes (Bytes xs) = xs

instance showSlot ∷ Show Slot where
  show  Slot = "_"
  show  bs   = show $ bytes bs

type Procedure = Array Slot

type ToCompile = {
  name ∷ String,
  args ∷ ParameterCount,
  data ∷ Array Bytes
}

type Signature = {
  name ∷ String,
  args ∷ ParameterCount,
  body ∷ Procedure
}

signatures ∷ Array Signature
signatures = [
  {name: "f64", args: Fixed 1, body: [Bytes [68], Slot]},
  {name: "+", args: Variadic 2, body: [Bytes [160]]},
  {name: "-", args: Variadic 2, body: [Bytes [161]]},
  {name: "*", args: Variadic 2, body: [Bytes [162]]},
  {name: "/", args: Variadic 2, body: [Bytes [163]]},
  {name: "=", args: Fixed 2, body: [Bytes [97], Slot, Slot]},
  {name: "!=", args: Fixed 2, body: [Bytes [98], Slot, Slot]},
  {name: "<", args: Fixed 2, body: [Bytes [99], Slot, Slot]},
  {name: ">", args: Fixed 2, body: [Bytes [100], Slot, Slot]},
  {name: "<=", args: Fixed 2, body: [Bytes [101], Slot, Slot]},
  {name: ">=", args: Fixed 2, body: [Bytes [102], Slot, Slot]}
] 
