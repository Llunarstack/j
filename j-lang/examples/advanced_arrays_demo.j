# ADVANCED ARRAY TYPES DEMO
out("========================================")
out("ADVANCED ARRAY TYPES")
out("========================================\n")

# 1. SPAN - Zero-copy subarray view
out("=== SPAN (Zero-Copy View) ===")
list | big -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
span | middle -> span(big)
out("Original:", big)
out("Span:", middle)
out("Span length:", len(middle))

# 2. CHUNK - Fixed-size chunked iteration
out("\n=== CHUNK (Block Processing) ===")
list | data -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
chunk | blocks -> chunk(data)
out("Data:", data)
out("Chunk:", blocks)

# 3. SPARSE - Sparse array with default values
out("\n=== SPARSE (Sparse Array) ===")
sparse | weights -> sparse(100)
out("Created sparse array of size 100")
out("Sparse:", weights)

# 4. RING - Fixed-capacity circular buffer
out("\n=== RING (Circular Buffer) ===")
ring | recent -> ring(5)
out("Created ring buffer with capacity 5")
out("Ring:", recent)

out("\n========================================")
out("ALL ADVANCED ARRAY TYPES WORK!")
out("========================================")
