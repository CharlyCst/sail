default Order dec
$include <prelude.sail>

/* Low-precedence type-level expressions (`if`, `div`, `mod`) used as
   operands of arithmetic must be parenthesised in the generated Lean;
   e.g. `if c then 8 else 4 * 8` would be parsed by Lean as
   `if c then 8 else (4 * 8)`.  This mirrors FLEN in sail-riscv. */

type ext_d_supported : Bool = true
type flen_bytes : Int = if ext_d_supported then 8 else 4
type flen : Int = flen_bytes * 8
type flenbits = bits(flen)

type sum_if : Int = 1 + (if ext_d_supported then 2 else 3)
type pow_if : Int = 2 ^ (if ext_d_supported then 3 else 4) * 2
type mul_div : Int = 2 * div(7, 2)
type mul_mod : Int = 2 * mod(7, 4)

val f : flenbits -> bits(64)
function f(x) = x

val g : bits(sum_if) -> bits(3)
function g(x) = x

val h : bits(pow_if) -> bits(16)
function h(x) = x

val i : bits(mul_div) -> bits(6)
function i(x) = x

val j : bits(mul_mod) -> bits(6)
function j(x) = x
