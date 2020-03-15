module Actions.TypeChecker where

import Prelude (($), (<>), (==), (<<<), eq, show)
import Data.Array (find)
import Data.Either (Either(..), note)
import Models.Parameters (ParameterCount)
import Models.Procedures (Signature, signatures)

lookup ∷ String → Either String Signature
lookup x = err $ find (eq x <<< _.name) signatures
  where err = note $ "Procedure not found: " <> x

match ∷ ParameterCount → Signature → Either String Signature
match x s = if x == s.args then Right s else Left err
  where err = "Procedure " <> s.name <> " expects " <> 
              (show s.args) <> " args. Got " <> (show x) <> "."

