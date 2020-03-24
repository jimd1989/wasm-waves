module Models.Exp where

import Prelude (class Show, (<=<), map, show)
import Data.Array (fromFoldable)
import Data.Either (Either(..), note)
import Data.List (List, head, tail)
import Helpers.Unicode ((∘))

data Exp = Const String | Atom String | Ls (List Exp) | Num Number

instance showExp ∷ Show Exp where
  show (Const a) = a
  show (Atom  a) = a
  show (Ls   as) = show as
  show (Num   n) = show n

getAtom ∷ Exp → Either String String
getAtom (Atom s) = Right s
getAtom _        = Left "Head of expression is not a symbol."

getName ∷ List Exp → Either String String
getName = getAtom <=< note err ∘ head
  where err = "Empty expression."

getArgs ∷ List Exp → Either String (Array Exp)
getArgs = note err ∘ map fromFoldable ∘ tail
  where err = "Malformed arguments to expression."
