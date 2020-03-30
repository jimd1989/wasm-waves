module Main where

import Data.Either (Either)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Actions.Compiler (compile)
import Actions.Parser (parse)
import Helpers.Types (Bytes)
import Helpers.Unicode ((◁), (◀))
import Models.Wasm.Sections.Main (header)

wasm ∷ String → Either String Bytes
wasm = header ◁ compile ◀ parse 

main :: Effect Unit
main = do
  log "Hello sailor!"
