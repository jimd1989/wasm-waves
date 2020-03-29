module Models.Parameters where

import Prelude (class Eq, class Show, (==), show)
import Data.Either (Either(..))
import Helpers.Unicode ((◇), (≥))

data ParameterCount = Variadic Int | Fixed Int

extract ∷ ParameterCount → Either Int Int
extract (Variadic α) = Right α
extract (Fixed    α) = Left  α

eqParameterCountImpl ∷ ParameterCount → ParameterCount → Boolean
eqParameterCountImpl (Fixed α) (Variadic ω) = α ≥ ω
eqParameterCountImpl (Fixed α) (Fixed    ω) = α == ω
eqParameterCountImpl  _         _           = true

instance parameterCountEq ∷ Eq ParameterCount where
  eq = eqParameterCountImpl

instance parameterCountShow ∷ Show ParameterCount where
  show (Variadic  α) = show α ◇ " ‥ ∞"
  show (Fixed     α) = show α
