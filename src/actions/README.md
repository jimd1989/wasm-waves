# Overview

The `Actions` module contains the bulk of the program logic.

## Parser.purs

Parsing of user-defined s-expression strings into the `Exp` ADT takes place here. Uses conventions similar to the Parsec library.

## Compiler.purs

After the function string has been parsed into a recursive `Exp` tree, the compiler flattens this structure into an array of integers representing wasm bytecode. This is the most complex module in the codebase.

## Main.purs

The user's compiled function is wrapped in a master loop here, using wasm constants. The logic mirrors that of `wasm-loop-example.wat`. 
