# Main J file demonstrating the execute syntax

str | message -> "Running main.j file!"
out(message)

# Execute another J file using the new syntax
j; -> test.j

# Continue with more code after execution
str | final_message -> "Back in main.j - execution complete!"
out(final_message)