# Test span
out("Testing span")

list | data -> [1, 2, 3, 4, 5]
out("Data:", data)

span | view -> span(data)
out("Span:", view)

out("Done!")
