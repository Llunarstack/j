# Test function in same file
fn int | add_nums (int | a, int | b) > {
  return a + b
}

int | result -> add_nums(5, 3)
out(result)
