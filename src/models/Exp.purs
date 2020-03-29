module Models.Exp where

import Prelude (class Show, show)
import Data.Array (fromFoldable)
import Data.Either (Either(..), note)
import Data.List (List, head, tail)
import Helpers.Unicode ((∘), (◁), (◀))

data Exp = Const String | Atom String | Ls (List Exp) | Num Number

instance showExp ∷ Show Exp where
  show (Const α) = α
  show (Atom  α) = α
  show (Ls    α) = show α
  show (Num   α) = show α

getAtom ∷ Exp → Either String String
getAtom (Atom α) = Right α
getAtom _        = Left "Head of expression is not a symbol."

getName ∷ List Exp → Either String String
getName = getAtom ◀ note err ∘ head
  where err = "Empty expression."

getArgs ∷ List Exp → Either String (Array Exp)
getArgs = note err ∘ fromFoldable ◁ tail
  where err = "Malformed arguments to expression."
