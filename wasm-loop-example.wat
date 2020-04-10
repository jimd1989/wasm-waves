(module
  (global $phase (mut f32) (f32.const 0))
  (global $len i32 (i32.const 3840))
  (memory $mem 1 1)
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
  (export "f" (func $f))
)
