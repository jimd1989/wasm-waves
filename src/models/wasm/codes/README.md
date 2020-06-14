# Overview

The `Codes` module contains integer constants that correspond directly to various wasm opcodes.

## Addresses.purs

Global and local variables in wasm are referred to internally as offsets. Variables `x y z` would be referenced as `0 1 2` respectively. There is no distinction between a parameter to a function and a local variable. This file contains the addresses of global vars in the binary and local vars in the main function `f` and assigns names to them for easy reference elsewhere. `rf1 rf2 ri1 ri2` are general purpose registers for float and int calculations respectively.

## Control.purs

Opcodes for looping and branching instructions.

## Operations.purs

Opcodes for general instructions, such as arithmetic and comparisons.

## Types.purs

Opcodes for data type identifiers, such as ints and floats.
