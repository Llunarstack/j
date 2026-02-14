// Control flow test
out("Testing Control Flow")

// If/else
int | x -> 10
if x > 5 : out("x is greater than 5")
if x < 5 : out("x is less than 5") else out("x is not less than 5")

// While loop
int | counter -> 0
while counter < 3 : {
  out(counter)
  counter -> counter + 1
}

// For loop
i in 1..4 : out(i)

// Match
int | val -> 2
match val : {
  1 > out("one")
  2 > out("two")
  _ > out("other")
}

out("All control flow works!")
