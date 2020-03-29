# WASM Waves

A learning project that seeks to compile arithmetic s-expressions representing wave functions directly to Webassembly bytecode. These waves will ultimately be graphed and played back as audio.

Currently working on parsing and basic compiler logic. Not concerned with functioning wasm yet.

## Syntax

Common Haskell operators have been given unicode synonyms in the interest of brevity. See `src/helpers/Unicode.purs` for the Vim digraphs needed to create these symbols.

| Symbol | Procedure            |
|--------|----------------------|
| ◇      | append               |
| ∘      | compose              |
| ◁      | compose (map f)      |
| ◀      | Kleisli compose      |
| ⊙      | map                  |
| ⊖      | map flipped          |
| ●      | apply                |
| ≤      | Less than or equal   |
| ≥      | Greater than or equal|
