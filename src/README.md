# Overview

Thanks for showing interest in the source code. This is a very simple program that operates around one main procedure: a loop that performs a user-defined function `f` against the phase `θ` of a signal, and fills a sample buffer with these output values. The code here does two things:

- Parse user input into a flat array of integers representing Webassembly bytecode.
- Append more integers, representing Webassembly boilerplate, around this array.

Keep those ideas in mind and this shouldn't be too hard to read. Refer to the file `wasm-loop-example.wat` for reference.

## Style

- No line is more than 80 characters.
- Variables are written APL style: α and ω. This is a deliberate limitation to keep the number of parameters small, and ensure the type signatures and function names are descriptive enough to render full variable names unnecessary.
- Point free functions are preferred where reasonable. Read bottom to top, right to left. When composing, I've elected to use full procedure names rather than infix operators wrapped in parentheses.
- I'm proud to say there is no `do` notation in this codebase. It's not forbidden, but a good use case for it has not appeared yet.

## Syntax

Common Haskell operators have been given unicode synonyms in the interest of brevity. I use Vim, so it's easy to input these characters.

| Symbol | Procedure            | Vim digraph |
|--------|----------------------|-------------|
| ◇      | append               | Dw          |
| ∘      | compose              | Ob          |
| ◁      | compose (map f)      | Tl          |
| ◀      | Kleisli compose      | PL          |
| ⊙      | map                  | 0.          |
| ⊖      | map flipped          | :dig mr 8854|
| ●      | apply                | 0M          |
| ≤      | Less than or equal   | =<          |
| ≥      | Greater than or equal| >=          |

