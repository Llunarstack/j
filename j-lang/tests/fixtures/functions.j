// Test function definitions and calls
fn | add(int | a, int | b) > a + b

fn | greet(str | name) > {
    out("Hello, " + name + "!")
}

// Test function calls
int | result -> add(5, 3)
out("5 + 3 = " + str(result))

greet("J Language")
