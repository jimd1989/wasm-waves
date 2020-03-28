module Main where

import Data.Either (Either)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Actions.Compiler (compile)
import Actions.Parser (parse)
import Helpers.Unicode ((◁), (◀))
import Models.Headers (appendHeader)
import Models.Signatures (Bytes)

wasm ∷ String → Either String Bytes
wasm = appendHeader ◁ compile ◀ parse 

main :: Effect Unit
main = do
  log "Hello sailor!"
