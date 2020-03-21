module Helpers.Combinators where

import Prelude ((<=<))
import Control.Applicative (class Applicative)
import Control.Bind (class Bind)
import Data.Bitraversable (bisequence)
import Data.Profunctor.Strong (fanout)
import Data.Tuple (uncurry)
import Helpers.Unicode((∘))

blackbird :: ∀ a b c d. (c → d) → (a → b → c) → a → b → d
blackbird = (∘)∘(∘)
infixr 8 blackbird as ...

liftFork ∷ ∀ a b c d f.
  Bind f ⇒ Applicative f ⇒ (b → c → f d) → (a → f b) → (a → f c) → a → f d
liftFork f g h = uncurry f <=< bisequence ∘ fanout g h
