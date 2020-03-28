module Helpers.Combinators where

import Prelude ((<=<), (<<<), compose, map)
import Control.Applicative (class Applicative)
import Control.Bind (class Bind)
import Data.Bitraversable (bisequence)
import Data.Profunctor.Strong (fanout)
import Data.Functor (class Functor)
import Data.Tuple (uncurry)

blackbird :: ∀ a b c d. (c → d) → (a → b → c) → a → b → d
blackbird = (<<<)<<<(<<<)
infixr 8 blackbird as ...

mapCompose ∷ ∀ a b c f. Functor f ⇒ (a → b) → (c → f a) → c → f b
mapCompose f = compose (map f)

liftFork ∷ ∀ a b c d f.
  Bind f ⇒ Applicative f ⇒ (b → c → f d) → (a → f b) → (a → f c) → a → f d
liftFork f g h = uncurry f <=< bisequence <<< fanout g h
