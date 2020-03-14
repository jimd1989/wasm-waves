module Models.Exp where

import Prelude (class Show, (<>), show)
import Data.List(List)

data Exp = Atom String | Ls (List Exp) | Num Number

instance showExp ∷ Show Exp where
  show (Atom a) = a <> " "
  show (Ls as ) = show as
  show (Num n ) = (show n) <> " "
