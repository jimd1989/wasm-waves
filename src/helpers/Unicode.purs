module Helpers.Unicode where

import Control.Apply (apply)
import Control.Bind (composeKleisliFlipped)
import Control.Semigroupoid (compose)
import Data.Functor (map, mapFlipped)
import Data.Ord (lessThanOrEq, greaterThanOrEq)
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

-- dig mr 8854
infixl 1 mapFlipped as ⊖

-- Digraph 0M
infixl 4 apply as ●

-- Digraph =<
infixl 4 lessThanOrEq as ≤

-- Digraph >=
infixl 4 greaterThanOrEq as ≥
