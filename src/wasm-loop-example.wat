(module
  (global $len i32 (i32.const 3840))
  (global $phase (mut f32) (f32.const 0))
  (memory $mem 1 1)
  (func $sin (param $x f32) (result f32)
    get_local $x
    f32.const 3.141592653589793
    f32.sub
    f32.const 0.318309886183791
    f32.mul
    tee_local $x
    get_local $x
    get_local $x
    get_local $x
    get_local $x
    f32.const -1.66451778959003
    f32.mul
    f32.mul
    f32.const 4.74829052566064
    f32.add
    f32.mul
    f32.mul
    f32.const -3.09012486790893
    f32.add
    f32.mul
  )
  (func $f (param $inc f32)
    (local $p f32) (local $rf1 f32) (local $rf2 f32)
    (local $n i32) (local $ri1 i32) (local $ri2 i32)    
  get_global $phase
  set_local $p
  i32.const 0
  set_local $n
  loop $L
    ;; populate stack with current buffer position and θ
    get_local $n
    get_local $n
    get_local $p
    ;; θ += frequency
    get_local $inc
    f32.add
    ;; θ % τ
    f32.const 6.2831853071795864769252
    f32.div
    tee_local $p
    get_local $p
    f32.trunc
    f32.sub
    f32.const 6.2831853071795864769252
    f32.mul
    set_local $p
    ;; user-defined operations against θ take place here
    ;; f(θ) ...
    ;; just using identity function here
    get_local $p
    ;; result of f(θ) and buffer pointer n should be on stack now
    f32.store
    ;; increment buffer pointer by sizeof(f32)
    i32.const 4
    i32.add
    tee_local $n
    ;; check if pointer has reached end of buffer, break loop if so
    get_global $len
    i32.lt_u
    br_if $L
  end
  get_local $p
  set_global $phase
  )
  (export "sin" (func $sin))
  (export "f" (func $f))
  (export "memory" (memory $mem))
)
