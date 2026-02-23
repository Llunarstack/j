# Simple singleton test

singleton class | Config {
    int | value -> 42
}

c1 -> Config()
out(c1.value)

c2 -> Config()
out(c2.value)

out("Done!")
