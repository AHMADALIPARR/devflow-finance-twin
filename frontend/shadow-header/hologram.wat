;; SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
(module
  (import "math" "sin" (func $sin (param f64) (result f64)))
  (import "math" "cos" (func $cos (param f64) (result f64)))
  (memory (export "memory") 4 4)
  ;; Fixed demo ABI: key[0..31], challenge[32..47], expected[48..63].
  ;; Working state[64..79], round scratch[80..95]; pixels start at 1024.
  ;; Matches CloneGate.decrypt: reverse key, initial XOR, 14 toy rounds.
  (func (export "attest") (result i32)
    (local $i i32) (local $r i32) (local $row i32) (local $col i32)
    (loop $initial
      (i32.store8 (i32.add (i32.const 64) (local.get $i))
        (i32.xor (i32.load8_u (i32.add (i32.const 32) (local.get $i)))
          (i32.load8_u (i32.sub (i32.const 31) (local.get $i)))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $initial (i32.lt_u (local.get $i) (i32.const 16))))
    (local.set $r (i32.const 1))
    (loop $round
      (local.set $i (i32.const 0))
      (loop $cell
        (local.set $row (i32.div_u (local.get $i) (i32.const 4)))
        (local.set $col (i32.rem_u (local.get $i) (i32.const 4)))
        (i32.store8 (i32.add (i32.const 80) (local.get $i))
          (i32.xor
            (i32.and (i32.add (i32.load8_u
              (i32.add (i32.const 64) (i32.add (i32.mul (local.get $row) (i32.const 4))
                (i32.rem_u (i32.add (local.get $col) (local.get $row)) (i32.const 4))))) (i32.const 1)) (i32.const 255))
            (i32.load8_u (i32.sub (i32.const 31)
              (i32.rem_u (i32.add (local.get $i) (local.get $r)) (i32.const 32))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br_if $cell (i32.lt_u (local.get $i) (i32.const 16))))
      (memory.copy (i32.const 64) (i32.const 80) (i32.const 16))
      (local.set $r (i32.add (local.get $r) (i32.const 1)))
      (br_if $round (i32.le_u (local.get $r) (i32.const 14))))
    (local.set $i (i32.const 0))
    (loop $compare
      (if (i32.ne (i32.load8_u (i32.add (i32.const 64) (local.get $i)))
                  (i32.load8_u (i32.add (i32.const 48) (local.get $i))))
        (then (return (i32.const 0))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $compare (i32.lt_u (local.get $i) (i32.const 16))))
    (i32.const 1))
  ;; Bounded CPU interference framebuffer; invalid dimensions write nothing.
  (func (export "render") (param $w i32) (param $h i32) (param $t f64) (result i32)
    (local $i i32) (local $p i32) (local $x f64) (local $y f64) (local $f f64)
    (if (i32.or (i32.or (i32.eqz (local.get $w)) (i32.gt_u (local.get $w) (i32.const 320)))
                (i32.or (i32.eqz (local.get $h)) (i32.gt_u (local.get $h) (i32.const 160))))
      (then (return (i32.const 0))))
    (loop $pixel
      (local.set $x (f64.div (f64.convert_i32_u (i32.rem_u (local.get $i) (local.get $w))) (f64.convert_i32_u (local.get $w))))
      (local.set $y (f64.div (f64.convert_i32_u (i32.div_u (local.get $i) (local.get $w))) (f64.convert_i32_u (local.get $h))))
      (local.set $f (f64.mul (f64.const 0.25) (f64.add (f64.const 2)
        (f64.add (call $sin (f64.add (f64.mul (local.get $x) (f64.const 22)) (local.get $t)))
          (call $cos (f64.sub (f64.mul (local.get $y) (f64.const 26)) (f64.mul (local.get $t) (f64.const 0.7))))))))
      (local.set $p (i32.add (i32.const 1024) (i32.mul (local.get $i) (i32.const 4))))
      (i32.store8 (local.get $p) (i32.trunc_f64_u (f64.add (f64.const 3) (f64.mul (local.get $f) (f64.const 75)))))
      (i32.store8 (i32.add (local.get $p) (i32.const 1)) (i32.trunc_f64_u (f64.add (f64.const 16) (f64.mul (local.get $f) (f64.const 185)))))
      (i32.store8 (i32.add (local.get $p) (i32.const 2)) (i32.trunc_f64_u (f64.add (f64.const 45) (f64.mul (local.get $f) (f64.const 200)))))
      (i32.store8 (i32.add (local.get $p) (i32.const 3)) (i32.const 255))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $pixel (i32.lt_u (local.get $i) (i32.mul (local.get $w) (local.get $h)))))
    (i32.mul (i32.mul (local.get $w) (local.get $h)) (i32.const 4)))
)
