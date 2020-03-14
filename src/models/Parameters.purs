module Models.Parameters where

import Prelude (class Eq, class Show, eq, show)

data ParameterCount = Variadic | Parameters Int

eqParameterCountImpl ∷ ParameterCount → ParameterCount → Boolean
eqParameterCountImpl  Variadic       _             = true
eqParameterCountImpl  _              Variadic      = true
eqParameterCountImpl (Parameters n) (Parameters m) = eq n m

instance parameterCountEq ∷ Eq ParameterCount where
  eq = eqParameterCountImpl

instance parameterCountShow ∷ Show ParameterCount where
  show  Variadic      = "∞"
  show (Parameters n) = show n
