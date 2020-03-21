module Models.Parameters where

import Prelude (class Eq, class Show, (>=), (==), show)
import Helpers.Unicode ((◇))

data ParameterCount = Variadic Int | Fixed Int

eqParameterCountImpl ∷ ParameterCount → ParameterCount → Boolean
eqParameterCountImpl (Fixed n) (Variadic m) = n >= m
eqParameterCountImpl (Fixed n) (Fixed    m) = n == m
eqParameterCountImpl  _         _           = true

instance parameterCountEq ∷ Eq ParameterCount where
  eq = eqParameterCountImpl

instance parameterCountShow ∷ Show ParameterCount where
  show (Variadic  n) = show n ◇ " ‥ ∞"
  show (Fixed     n) = show n
