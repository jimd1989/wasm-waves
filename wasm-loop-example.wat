(module
  (global $phase (mut f32) (f32.const 0))
  (global $len i32 (i32.const 3840))
  (global $tau f32 (f32.const 6.2831853071795864769252))
  (memory $mem 1 1)
  (func $fmod (param $x f32) (param $y f32) (result f32)
    get_local $x
    get_local $y
    f32.div
    tee_local $x
    get_local $x
    f32.floor
    f32.sub
    get_local $y
    f32.mul
  )
  (func $f (param $inc f32)
    (local $p f32) (local $n i32)
  get_global $phase
  set_local $p
  i32.const 0
  set_local $n
  loop $L
    get_local $n
    get_local $n
    get_local $p
    get_local $inc
    f32.add
    get_global $tau
    f32.div
    tee_local $p
    get_local $p
    f32.floor
    f32.sub
    get_global $tau
    f32.mul
    tee_local $p
    f32.store
    i32.const 4
    i32.add
    tee_local $n
    get_global $len
    i32.lt_u
    br_if $L
  end
  get_local $p
  set_global $phase
  )
  (export "memory" (memory $mem))
  (export "fmod" (func $fmod))
  (export "f" (func $f))
)
