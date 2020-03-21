module Helpers.Unicode where

import Control.Semigroupoid (compose)
import Data.Functor (map)
import Data.Semigroup (append)

-- Digraph Dw
infixr 5 append as ◇

-- Digraph Ob
infixr 9 compose as ∘

-- Digraph 0.
infixl 4 map as ⊙
