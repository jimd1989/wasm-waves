module Actions.Compiler where

import Prelude ((<>), (>>=))
import Control.Applicative (pure)
import Control.Apply (lift5)
import Data.Array (head, tail)
import Data.Maybe(Maybe(..))
import Models.Procedures (Bytes, Procedure, Signature,
                          Slot(..), ToCompile, bytes)

type Compilation = {
  compiled ∷ Bytes,
  data ∷ Array Bytes,
  body ∷ Procedure
}

compilation ∷ ToCompile → Signature → Compilation
compilation tc s = {compiled: [], data: tc.data, body: s.body}

push ∷ Bytes → Bytes → Slot → Array Bytes → Procedure → Compilation
push c d Slot rD rP = {compiled: d <> c, data: rD, body: rP}
push c d p    rD rP = {compiled: (bytes p) <> c, data: [d] <> rD, body: rP}

compile ∷ Compilation → Maybe Bytes
compile {compiled: co, data: [], body: []} = pure co
compile {compiled: co, data: da, body: []} = Nothing
compile {compiled: co, data: [], body: bo} = Nothing
compile {compiled: co, data: da, body: bo} = merge co da bo >>= compile
  where merge c d b = lift5 push (pure c) (head d) (head b) (tail d) (tail b)
