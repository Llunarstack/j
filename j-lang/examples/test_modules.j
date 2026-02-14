out("=== MODULE SYSTEM TEST ===")
out("")

import examples.math_utils

out("Testing imported functions:")
int | sum_result -> math_add(5, 3)
out("math_add(5, 3) = ")
out(sum_result)

int | mult_result -> math_multiply(4, 7)
out("math_multiply(4, 7) = ")
out(mult_result)

int | sq_result -> math_square(9)
out("math_square(9) = ")
out(sq_result)

int | fact_result -> math_factorial(5)
out("math_factorial(5) = ")
out(fact_result)

out("")
out("Testing imported constants:")
out("PI_APPROX = ")
out(PI_APPROX)
out("E_APPROX = ")
out(E_APPROX)

out("")
out("✓ Module system works!")
