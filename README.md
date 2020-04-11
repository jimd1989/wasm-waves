# WASM Waves

A learning project that seeks to compile arithmetic s-expressions representing wave functions directly to Webassembly bytecode. These waves will ultimately be graphed and played back as audio.

## MVP

The function `wasm` in `Main` can parse an s-expression for a function `f(x)`, where `x` is the current phase of a wave.

Representing `f(x) = x²` would involve the following session.

```
$ pulp repl
PSCi, version 0.13.6
Type :? for help

import Prelude

> import Main
> wasm "(* x x)"
"[0,97,115,109,1,0,0,0,1,5,1,96,1,125,0,3,2,1,0,5,4,1,1,1,1,6,15,2,127,0,65,128,30,11,125,1,67,0,0,0,0,11,7,14,2,1,102,0,0,6,109,101,109,111,114,121,2,0,10,70,1,68,2,1,125,1,127,35,1,33,1,65,0,33,2,3,64,32,2,32,2,32,1,32,0,146,67,219,15,201,64,149,34,1,32,1,143,147,67,219,15,201,64,148,33,1,32,1,32,1,148,56,2,0,65,4,106,34,2,35,0,73,13,0,11,32,1,36,1,11]"
```

`wasm` returns an array of 8 bit integers representing raw Webassembly. It can be loaded in the browser with the following JS boilerplate.

```
» w = new WebAssembly.Instance(new WebAssembly.Module(new Uint8Array([0,97,115,109,1,0,0,0,1,5,1,96,1,125,0,3,2,1,0,5,4,1,1,1,1,6,15,2,127,0,65,128,30,11,125,1,67,0,0,0,0,11,7,14,2,1,102,0,0,6,109,101,109,111,114,121,2,0,10,70,1,68,2,1,125,1,127,35,1,33,1,65,0,33,2,3,64,32,2,32,2,32,1,32,0,146,67,219,15,201,64,149,34,1,32,1,143,147,67,219,15,201,64,148,33,1,32,1,32,1,148,56,2,0,65,4,106,34,2,35,0,73,13,0,11,32,1,36,1,11])))
```

The user-defined function is available as `f` in `w.exports.f`, and its buffer is available as `memory` in `w.exports.memory.` This memory is exposed to Javascript by creating a `Float32Array` over it.

```
» a = new Float32Array(w.exports.buffer)
← Float32Array(16384) [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, … ]
```

Invoking `w.exports.f(pitch)` will increment the phase of a wave by `pitch` for each sample, modulo 2π. The user-defined function will take this value as its import, and write its output to the `memory` buffer. One call to `w.exports.f()` fills the entire buffer. The program will eventually read this buffer for audio and graphing, but for now, it can be inspected manually as a proof of concept.

```
» w.exports.f(0.1)
← undefined
» a
← Float32Array(16384) [ 0.010000000707805157, 0.04000000283122063, 0.09000000357627869, 0.1600000113248825, 0.25, 0.36000001430511475, 0.49000006914138794, 0.64000004529953, 0.8100000619888306, 1, … ]
» w.exports.f(0.1)
← undefined
» a
← Float32Array(16384) [ 3.4305500984191895, 3.810985565185547, 4.21142053604126, 4.631855010986328, 5.07228946685791, 5.532723903656006, 6.013158321380615, 6.513592720031738, 7.034027099609375, 7.574460983276367, … ]
```

This is a nonsensical function for audio purposes. This program won't be useful until trigonometry operations are implemented. You can see how the looping and memory writing operations work though.

## Lacking

+ Trig functions
+ Random numbers (for noise)
+ Frontend 
+ Interaction with web audio
+ Tests
