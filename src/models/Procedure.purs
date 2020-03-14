module Models.Procedure where

import Models.Bytes (Bytes)
import Models.Parameters (ParameterCount)

type Procedure = {
  name ∷ String,
  parameters ∷ ParameterCount,
  bytes ∷ Bytes
}
