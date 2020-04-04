(module
  (memory $mem 1 1)
  (func $f
    (local $phase f32) (local $len i32) (local $n i32)
  i32.const 0
  f32.load
  set_local $phase
  i32.const 40
  set_local $len
  i32.const 4
  set_local $n
  loop $L
    get_local $n
    get_local $n
    get_local $phase
    f32.const 0.5
    f32.add
    tee_local $phase
    f32.store
    i32.const 4
    i32.add
    tee_local $n
    get_local $len
    i32.lt_u
    br_if $L
  end
  i32.const 0
  get_local $phase
  f32.store
  )
  (export "memory" (memory $mem))
  (export "f" (func $f))
)
