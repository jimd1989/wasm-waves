module Models.Slots where

import Prelude (class Show, ($), show)

type Bytes = Array Int

data Slot = Free | Full Bytes

type Skeleton = Array Slot

contents ∷ Slot → Bytes
contents Free      = []
contents (Full xs) = xs

instance showSlot ∷ Show Slot where
  show  Free = "_"
  show  bs   = show $ contents bs
