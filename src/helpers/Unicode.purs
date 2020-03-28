module Helpers.Unicode where

import Control.Bind (composeKleisliFlipped)
import Control.Semigroupoid (compose)
import Data.Functor (map)
import Data.Semigroup (append)
import Helpers.Combinators (mapCompose)

-- Digraph Dw
infixr 5 append as ◇

-- Digraph Ob
infixr 9 compose as ∘

-- Digraph Tl = ◁
infixr 9 mapCompose as ◁

-- Digraph PL = ◀
infixr 1 composeKleisliFlipped as ◀

-- Digraph 0.
infixl 4 map as ⊙
