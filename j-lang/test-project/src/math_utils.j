# Math utilities module

fn int | add_nums (int | a, int | b) > {
  return a + b
}

fn int | mult (int | a, int | b) > {
  return a * b
}

fn int | square (int | x) > {
  return x * x
}

fn int | factorial (int | n) > {
  if n <= 1 {
    return 1
  }
  return n * factorial(n - 1)
}
