# WASM Waves

A learning project that seeks to compile arithmetic s-expressions representing wave functions directly to Webassembly bytecode. These waves will ultimately be graphed and played back as audio.

## MVP

The function `wasm` in `Main` can parse an s-expression for a function `f(x)`, where `x` is the current phase of a wave.

Representing `f(x) = sin(x)` would involve the following session.

```
$ pulp repl
PSCi, version 0.13.6
Type :? for help

import Prelude

> import Main
> wasm "(sin x)"
"[0,97,115,109,1,0,0,0,1,5,1,96,1,125,0,3,2,1,0,5,4,1,1,1,1,6,15,2,127,0,65,128,30,11,125,1,67,0,0,0,0,11,7,14,2,1,102,0,0,6,109,101,109,111,114,121,2,0,10,111,1,109,2,3,125,3,127,35,1,33,1,65,0,33,4,3,64,32,4,32,4,32,1,32,0,146,67,219,15,201,64,149,34,1,32,1,143,147,67,219,15,201,64,148,33,1,32,1,67,219,15,73,64,147,67,131,249,162,62,148,34,2,32,2,32,2,32,2,32,2,67,235,14,213,191,148,148,67,255,241,151,64,146,148,148,67,155,196,69,192,146,148,56,2,0,65,4,106,34,4,35,0,73,13,0,11,32,1,36,1,11]"
```

`wasm` returns an array of 8 bit integers representing raw Webassembly. It can be loaded in the browser with the following JS boilerplate.

```
» w = new WebAssembly.Instance(new WebAssembly.Module(new Uint8Array([0,97,115,109,1,0,0,0,1,5,1,96,1,125,0,3,2,1,0,5,4,1,1,1,1,6,15,2,127,0,65,128,30,11,125,1,67,0,0,0,0,11,7,14,2,1,102,0,0,6,109,101,109,111,114,121,2,0,10,111,1,109,2,3,125,3,127,35,1,33,1,65,0,33,4,3,64,32,4,32,4,32,1,32,0,146,67,219,15,201,64,149,34,1,32,1,143,147,67,219,15,201,64,148,33,1,32,1,67,219,15,73,64,147,67,131,249,162,62,148,34,2,32,2,32,2,32,2,32,2,67,235,14,213,191,148,148,67,255,241,151,64,146,148,148,67,155,196,69,192,146,148,56,2,0,65,4,106,34,4,35,0,73,13,0,11,32,1,36,1,11])))
```

The user-defined function is available as `f` in `w.exports.f`, and its buffer is available as `memory` in `w.exports.memory.` This memory is exposed to Javascript by creating a `Float32Array` over it.

```
» a = new Float32Array(w.exports.memory.buffer)
← Float32Array(16384) [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, … ]
```

Invoking `w.exports.f(pitch)` will increment the phase of a wave by `pitch` for each sample, modulo 2π. The user-defined function will take this value as its import, and write its output to the `memory` buffer. One call to `w.exports.f()` fills the entire buffer. The program will eventually read this buffer for audio and graphing, but for now, it can be inspected manually as a proof of concept.

```
» w.exports.f(0.1)
← undefined
» a
← Float32Array(16384) [ 0.8855069279670715, 0.9291098117828369, 0.9629318714141846, 0.986690878868103, 1.000226378440857, 1.0034931898117065, 0.9965551495552063, 0.9795779585838318, 0.9528239369392395, 0.9166438579559326, … ]
» w.exports.f(0.1)
← undefined
» a
← Float32Array(16384) [ 0.3057762384414673, 0.21068300306797028, 0.11361942440271378, 0.01549458783119917, -0.08277466148138046, -0.180271178483963, -0.2760827839374542, -0.3693091571331024, -0.45906856656074524, -0.5445046424865723, … ]
```

The pitch increment and buffer size need to be fine-tuned for actual audio purposes, but you can see from the terminal output alone that `f` produces a cyclic sinusoidal signal between -1 and 1.

## Lacking

+ Trig functions beyond `sin`.
+ Random numbers (for noise)
+ Frontend 
+ Interaction with web audio
+ Tests
