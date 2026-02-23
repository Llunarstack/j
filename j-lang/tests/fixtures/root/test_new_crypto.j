out("Test")
str | a -> "test"
str | b -> "other"
if secure_compare(a, b) == false {
    out("Different")
}
out("Done")
