module Models.Bytes where

import Prelude (class Show, show)

data Bytes = Slot | Bytes (Array Int)

instance showBytes ∷ Show Bytes where
  show  Slot      = "_"
  show (Bytes xs) = show xs
