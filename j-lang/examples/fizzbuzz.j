# FizzBuzz - Professional implementation in J
# Prints 1..N: Fizz if divisible by 3, Buzz by 5, FizzBuzz by both.

int | N -> 100

out("FizzBuzz (1 to 100)")
out("--------------------")

for n in range(1, 101) {
    cond(n) {
        |> n % 15 == 0 : {
            out("FizzBuzz")
        }
        |> n % 3 == 0 : {
            out("Fizz")
        }
        |> n % 5 == 0 : {
            out("Buzz")
        }
        |> else : {
            out(n)
        }
    }
}

out("--------------------")
out("Done.")
