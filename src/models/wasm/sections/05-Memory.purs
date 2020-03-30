module Models.Wasm.Sections.Memory where

import Helpers.Types (Byte, Bytes)
import Models.Wasm.Sections.Actions (header)

id ∷ Byte
id = 5

limited ∷ Byte
limited = 1

initialLength ∷ Byte
initialLength = 1

maxLength ∷ Byte
maxLength = 1

memoryEntry ∷ Bytes
memoryEntry = [limited, initialLength, maxLength]

memory ∷ Bytes
memory = header id [memoryEntry]
