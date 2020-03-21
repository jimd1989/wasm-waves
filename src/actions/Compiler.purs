module Actions.Compiler where

import Prelude (($), (==), (<*>), (>>=), (<=<), eq, flip, join, map, show)
import Control.Applicative (pure)
import Control.Apply (lift2, lift5)
import Control.Lazy (fix)
import Data.Array (find, head, length, replicate, tail)
import Data.List (List)
import Data.Traversable (sequence)
import Data.Either (Either(..), note)
import Data.Maybe(Maybe(..))
import Data.Profunctor.Choice (fanin)
import Data.Ring (sub)
import Data.Semigroup (append)
import Foreign.Numbers (toBytes)
import Helpers.Combinators (liftFork)
import Helpers.Unicode ((◇), (∘))
import Models.Compiler (Compilation, compilation)
import Models.Exp (Exp(..), getArgs, getName)
import Models.Parameters (ParameterCount(..))
import Models.Signatures (Signature, signatures, split)
import Models.Slots (Bytes, Skeleton, Slot(..), contents)

compile :: Exp → Either String Bytes
compile (Num n) = compileNum n
compile (Ls xs) = compileLs xs
compile  _      = Left "Internal compiler error. This is not your fault."

compileNum ∷ Number → Either String Bytes
compileNum = pure ∘ append [68] ∘ toBytes

compileLs ∷ List Exp → Either String Bytes
compileLs = note err ∘ compile' <=< toCompile
  where
    toCompile = (lift2 ∘ lift2) compilation rawData matched
    rawData   = fix \p -> join ∘ map (sequence ∘ map compile) ∘ getArgs
    matched   = liftFork match argCount toMatch
    argCount  = map (Fixed ∘ length) ∘ getArgs
    toMatch   = lookup <=< getName
    err       = "Internal compiler error. This is not your fault."

lookup ∷ String → Either String Signature
lookup x = err $ find (eq x ∘ _.name) signatures
  where err = note $ "Procedure not found: " ◇ x

match ∷ ParameterCount → Signature → Either String Signature
match x s = if x == s.args then Right s else Left err
  where err = "Procedure " ◇ s.name ◇ " expects " ◇ 
              (show s.args) ◇ " args. Got " ◇ (show x) ◇ "." 

skeleton ∷ Signature → Either String Skeleton
skeleton = note err ∘ fanin pure expand ∘ split
  where
    expand     = expandSlot <=< expandProc
    expandProc = flip append ∘ pure <*> repProc
    expandSlot = append ∘ pure <*> repSlot
    repProc    = (lift2 ∘ lift2) replicate (pure ∘ flip sub 2 ∘ length) head
    repSlot    = map (flip replicate Free ∘ flip sub 1 ∘ length) ∘ tail
    err        = "Internal compiler error. This is not your fault."

compile' ∷ Compilation → Maybe Bytes
compile' {compiled: co, data: [], body: []} = pure co
compile' {compiled: co, data: da, body: []} = Nothing
compile' {compiled: co, data: [], body: bo} = Nothing
compile' {compiled: co, data: da, body: bo} = merge co da bo >>= compile'
  where merge c d b = lift5 push (pure c) (head d) (head b) (tail d) (tail b)

push ∷ Bytes → Bytes → Slot → Array Bytes → Skeleton → Compilation
push c d Free rD rP = {compiled: d ◇ c,            data: rD,       body: rP}
push c d p    rD rP = {compiled: (contents p) ◇ c, data: [d] ◇ rD, body: rP}
