module Models.Signatures where

import Prelude (($), flip, join)
import Data.Bifunctor (bimap)
import Data.Either (Either(..))
import Data.Tuple (Tuple(..))
import Models.Parameters (ParameterCount(..))
import Models.Parameters as PS
import Models.Slots (Skeleton, Slot(..))

type Signature' = {
  name ∷ String,
  args ∷ ParameterCount,
  slots ∷ Array Int,
  body ∷ Array (Array Int)
}

split' ∷ Signature' → Either (Tuple Int Signature') (Tuple Int Signature')
split' s = join bimap (flip Tuple s) $ PS.split s.args

empty ∷ Array Int
empty = [0]

sig = {name: "-", args: Variadic 2, slots: [2, 1], body: [[161],empty,empty]}

signatures ∷ Array Signature'
signatures = [sig]

