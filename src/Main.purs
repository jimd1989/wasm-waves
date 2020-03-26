module Main where

import Prelude ((<=<), map)
import Data.Either (Either)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Actions.Parser
import Actions.Compiler
import Helpers.Unicode ((∘))
import Models.Headers (appendHeader)
import Models.Signatures (Bytes)

wasm ∷ String → Either String Bytes
wasm = map appendHeader ∘ compile <=< parse 

main :: Effect Unit
main = do
  log "Hello sailor!"
