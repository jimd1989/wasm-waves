module Models.Wasm.Sections.Exports where

import Prelude (($))
import Helpers.Types (Byte, Bytes)
import Helpers.Unicode ((◇))
import Models.Wasm.Sections.Actions (header, toBytes, withLength)
import Models.Wasm.Codes.Types (exportFunction, exportMemory)

id ∷ Byte
id = 7

function ∷ Bytes
function = (withLength $ toBytes "f") ◇ [exportFunction, 0]

memory ∷ Bytes
memory = (withLength $ toBytes "memory") ◇ [exportMemory, 0]

exports ∷ Bytes
exports = header id [function, memory]
