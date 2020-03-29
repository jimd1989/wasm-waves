module Models.Headers where

import Prelude (($), flip, join)
import Control.Apply (lift2)
import Data.Array (cons, length)
import Data.Bifunctor (bimap)
import Data.Enum (fromEnum)
import Data.Profunctor.Strong ((&&&))
import Data.Semigroup (append)
import Data.Semiring (add)
import Data.String.CodePoints (toCodePointArray)
import Data.Tuple (uncurry)
import Helpers.Unicode ((◇), (∘), (◁), (●))
import Models.Leb128 (leb128)
import Models.Opcodes (func, f32)
import Models.Signatures (Bytes)

type Byte = Int
type SectionId = Int
type Header = Array Int

header ∷ SectionId → Array Bytes → Header
header α = cons α ∘ section ∘ itemCount
  where
    itemCount     = leb128 ∘ length &&& join
    sectionLength = leb128 ∘ uncurry add ∘ join bimap length
    section       = lift2 append sectionLength (uncurry append)

toBytes ∷ String → Bytes
toBytes = fromEnum ◁ toCodePointArray

withLength ∷ Bytes → Bytes
withLength = flip append ● leb128 ∘ length

magicWord ∷ Bytes
magicWord = [0, 97, 115, 109]

version ∷ Bytes
version = [1, 0, 0, 0]

signaturesId ∷ SectionId
signaturesId = 1

fSignature ∷ Bytes
fSignature = [func, 1, f32, 1, f32]

signatures ∷ Header
signatures = header signaturesId [fSignature]

functionTypesId ∷ SectionId
functionTypesId = 3

functionTypes ∷ Header
functionTypes = header functionTypesId [[0]]

exportsId ∷ SectionId
exportsId = 7

fExportType ∷ Byte
fExportType = 0

fExport ∷ Bytes
fExport = withLength $ toBytes "f"

exports ∷ Header
exports = header exportsId [fExport]

codeId ∷ SectionId
codeId = 10

staticHeader ∷ Header
staticHeader = magicWord ◇ version ◇ signatures ◇ functionTypes ◇ exports

appendHeader ∷ Bytes → Bytes
appendHeader = append staticHeader ∘ cons codeId ∘ withLength ∘ cons 1
