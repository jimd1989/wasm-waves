# WASM Waves

A learning project that seeks to compile arithmetic s-expressions representing wave functions directly to Webassembly bytecode. These waves will ultimately be graphed and played back as audio.

Currently working on parsing and basic compiler logic. Not concerned with functioning wasm yet.

## MVP

The function `wasm` in `Main` can parse an s-expression for a function `f(x)` and return an array of bytes representing a wasm module.

Boolean expressions can be formed with `(? cond branch1 branch2)`.

```
> import Main 
> wasm "(? (< x 10) (* pi (* x x)) (* 2 pi x))"
(Right [0,97,115,109,1,0,0,0,1,6,1,96,1,125,1,125,3,2,1,0,7,5,1,1,102,0,0,10,41,1,39,0,32,0,67,0,0,32,65,93,4,125,67,219,15,73,64,32,0,32,0,148,148,5,67,0,0,0,64,67,219,15,73,64,32,0,148,148,11,11])
```

These bytes can be copied into a Javascript console to compile to wasm.

```
» w = new WebAssembly.Instance(new WebAssembly.Module(new Uint8Array([0,97,115,109,1,0,0,0,1,6,1,96,1,125,1,125,3,2,1,0,7,5,1,1,102,0,0,10,41,1,39,0,32,0,67,0,0,32,65,93,4,125,67,219,15,73,64,32,0,32,0,148,148,5,67,0,0,0,64,67,219,15,73,64,32,0,148,148,11,11])))
```

The user-defined function is available as `f` in `w.exports.f`.

```
» w.exports.f(9)
← 254.46900939941406

» w.exports.f(10)
← 62.83185577392578
```

This single function module is considered adequate for the eventual audio-rendering portion of this project. All performance-sensitive sound code will be executed across a global buffer in a master loop. Nothing more.

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

## Lacking

+ Trig functions
+ Random numbers (for noise)
+ Memory allocation/reading
+ Looping
+ Frontend 
+ Interaction with web audio
+ Tests
