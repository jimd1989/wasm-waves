module Helpers.Combinators where

import Prelude ((<<<))

blackbird :: ∀ a b c d. (c → d) → (a → b → c) → a → b → d
blackbird = (<<<) <<< (<<<)                       
infixr 8 blackbird as ...

