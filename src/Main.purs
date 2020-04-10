module Main where

import Prelude (identity, show)
import Data.Profunctor.Choice (fanin)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Console (log)
import Actions.Compiler (compile)
import Actions.Parser (parse)
import Helpers.Unicode ((∘), (◁), (◀))
import Models.Wasm.Sections.Main (header)

wasm ∷ String → String
wasm = fanin identity show ∘ (header ◁ compile ◀ parse)

main :: Effect Unit
main = do
  log "Hello sailor!"
