module Actions.Compiler where

import Prelude ((-), ($), (==), (<#>), (<*>), (<=<), eq, flip, join, map, show)
import Control.Applicative (pure)
import Control.Apply (lift2)
import Control.Lazy (fix)
import Data.Array ((..), cons, find, head, length, 
                   replicate, updateAtIndices, zip)
import Data.List (List)
import Data.Traversable (sequence)
import Data.Either (Either(..), note)
import Data.Maybe(Maybe)
import Data.Profunctor.Choice (fanin)
import Data.Semigroup (append)
import Data.Tuple (snd, uncurry)
import Foreign.Numbers (toBytes)
import Helpers.Combinators (liftFork)
import Helpers.Unicode ((◇), (∘))
import Models.Exp (Exp(..), getArgs, getName)
import Models.Parameters (ParameterCount(..))
import Models.Signatures (Bytes, Signature, empty, signatures, split)

compile :: Exp → Either String Bytes
compile (Num n) = compileNum n
compile (Ls xs) = compileLs xs
compile  _      = Left "Internal compiler error. This is not your fault."

compileNum ∷ Number → Either String Bytes
compileNum = pure ∘ cons 68 ∘ toBytes

compileLs ∷ List Exp → Either String Bytes
compileLs = (lift2 ∘ lift2) fill matched rawData
  where
    rawData   = fix \p -> join ∘ map (sequence ∘ map compile) ∘ getArgs
    matched   = expand <=< liftFork match argCount toMatch
    argCount  = map (Fixed ∘ length) ∘ getArgs
    toMatch   = lookup <=< getName

fill ∷ Signature → Array Bytes → Bytes
fill s = join ∘ flip updateAtIndices s.body ∘ zip s.slots

lookup ∷ String → Either String Signature
lookup x = err $ find (eq x ∘ _.name) signatures
  where err = note $ "Procedure not found: " ◇ x

match ∷ ParameterCount → Signature → Either String Signature
match x s = if x == a then Right s {args = exactArgs x a} else Left err
  where
    a   = s.args
    err = s.name ◇ " expects " ◇ (show a) ◇ " args. Got " ◇ (show x) ◇ "." 

exactArgs ∷ ParameterCount → ParameterCount → ParameterCount
exactArgs (Fixed n) (Variadic _) = (Variadic n)
exactArgs  _         a           =  a

expand ∷ Signature → Either String Signature
expand = note err ∘ fanin (pure ∘ snd) (uncurry expand') ∘ split
  where err = "Internal compiler error. This is not your fault."

expand' ∷ Int → Signature → Maybe Signature
expand' n s = body <#> {name: s.name, args: s.args, slots: range, body: _}
  where
    body  = proc s.body <#> slots
    proc  = append ∘ pure <*> map (replicate (n - 2)) ∘ head
    slots = append (replicate n empty)
    range = 0 .. (n - 1)
