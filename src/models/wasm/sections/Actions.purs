module Models.Wasm.Sections.Actions where

import Prelude (flip, join)
import Control.Apply (lift2)
import Data.Array (cons, length)
import Data.Bifunctor (bimap)
import Data.Enum (fromEnum)
import Data.Profunctor.Strong ((&&&))
import Data.Semigroup (append)
import Data.Semiring (add)
import Data.String.CodePoints (toCodePointArray)
import Data.Tuple (uncurry)
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((∘), (◁), (●))
import Models.Leb128 (leb128)

header ∷ Byte → Array Bytes → Bytes
header α = cons α ∘ section ∘ itemCount
  where
    itemCount     = leb128 ∘ length &&& join
    sectionLength = leb128 ∘ uncurry add ∘ join bimap length
    section       = lift2 append sectionLength (uncurry append)

toBytes ∷ String → Bytes
toBytes = fromEnum ◁ toCodePointArray

withLength ∷ Bytes → Bytes
withLength = flip append ● leb128 ∘ length
