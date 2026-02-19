# Test graph with unquoted keys
out("Testing graph...")

# Try with quoted keys
dict | graph1 -> {"A": ["B"], "B": ["C"], "C": []}
out("Graph 1:", graph1)

# Try with unquoted keys (might fail)
dict | graph2 -> {A: ["B"], B: ["C"], C: []}
out("Graph 2:", graph2)

out("Graph test completed!")
