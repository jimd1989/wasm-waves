module Actions.Compiler where

import Prelude ((-), ($), (==), eq, flip, join, map, show)
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
import Helpers.Types (Bytes)
import Helpers.Unicode ((◇), (∘), (⊙), (◁), (◀), (⊖), (●))
import Models.Constants (constants)
import Models.Exp (Exp(..), getArgs, getName)
import Models.Parameters (ParameterCount(..))
import Models.Signatures (Signature, empty, signatures, split)
import Models.Wasm.Codes.Operations (f32const)

compile :: Exp → Either String Bytes
compile (Const α) = compileConst α
compile (Num   α) = compileNum α
compile (Ls    α) = compileLs α
compile (Atom  α) = Left $ "Invalid argument: " ◇ α

compileConst ∷ String → Either String Bytes
compileConst α = err $ _.body ⊙ find (eq α ∘ _.name) constants
  where err = note $ "Variable not defined: " ◇ α

compileNum ∷ Number → Either String Bytes
compileNum = pure ∘ cons f32const ∘ toBytes

compileLs ∷ List Exp → Either String Bytes
compileLs = (lift2 ∘ lift2) fill matched rawData
  where
    rawData  = fix \α -> join ∘ (sequence ∘ map compile) ◁ getArgs
    matched  = expand ◀ liftFork match argCount toMatch
    argCount = (Fixed ∘ length) ◁ getArgs
    toMatch  = lookup ◀ getName

fill ∷ Signature → Array Bytes → Bytes
fill α = join ∘ flip updateAtIndices α.body ∘ zip α.slots

lookup ∷ String → Either String Signature
lookup α = err $ find (eq α ∘ _.name) signatures
  where err = note $ "Procedure not found: " ◇ α

match ∷ ParameterCount → Signature → Either String Signature
match α ω = if α == β then Right ω {args = exactArgs α β} else Left err
  where
    β   = ω.args
    err = ω.name ◇ " expects " ◇ (show β) ◇ " args. Got " ◇ (show α) ◇ "."

exactArgs ∷ ParameterCount → ParameterCount → ParameterCount
exactArgs (Fixed α) (Variadic _) = (Variadic α)
exactArgs  _         ω           =  ω

expand ∷ Signature → Either String Signature
expand = note err ∘ fanin (pure ∘ snd) (uncurry expand') ∘ split
  where err = "Internal compiler error. This is not your fault."

expand' ∷ Int → Signature → Maybe Signature
expand' α ω = body ⊖ {name: ω.name, args: ω.args, slots: range, body: _}
  where
    body  = proc ω.body ⊖ slots
    proc  = append ∘ pure ● (replicate (α - 2)) ◁ head
    slots = append (replicate α empty)
    range = 0 .. (α - 1)
