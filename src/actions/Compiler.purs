module Actions.Compiler where

import Prelude (($), (<>), (==), (<<<), (>>=), eq, show)
import Control.Applicative (pure)
import Control.Apply (lift5)
import Data.Array (find, head, tail)
import Data.Either (Either(..), note)
import Data.Maybe(Maybe(..))
import Models.Parameters (ParameterCount)
import Models.Procedures (Bytes, Procedure, Signature, Slot(..),
                          ToCompile, signatures, bytes)

type Compilation = {
  compiled ∷ Bytes,
  data ∷ Array Bytes,
  body ∷ Procedure
}

lookup ∷ String → Either String Signature
lookup x = err $ find (eq x <<< _.name) signatures
  where err = note $ "Procedure not found: " <> x

match ∷ ParameterCount → Signature → Either String Signature
match x s = if x == s.args then Right s else Left err
  where err = "Procedure " <> s.name <> " expects " <> 
              (show s.args) <> " args. Got " <> (show x) <> "."

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
