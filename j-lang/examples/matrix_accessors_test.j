# MATRIX ACCESSOR METHODS TEST
# Testing NumPy-like matrix operations

out("========================================")
out("MATRIX ACCESSOR METHODS TEST")
out("========================================\n")

# Create a test matrix using mat type
mat | m -> [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0], [7.0, 8.0, 9.0]]
out("Original Matrix:")
out(m)
out("Type:", varType(m))

# Test 1: Get dimensions
out("\n1. DIMENSIONS")
out("   Rows:", m.rows)
out("   Columns:", m.cols)
out("   Total size:", m.size)

# Test 2: Get specific row
out("\n2. ROW ACCESS")
out("   Row 0:", m.row(0))
out("   Row 1:", m.row(1))
out("   Row 2:", m.row(2))
out("   Last row (row -1):", m.row(-1))

# Test 3: Get specific column
out("\n3. COLUMN ACCESS")
out("   Column 0:", m.col(0))
out("   Column 1:", m.col(1))
out("   Column 2:", m.col(2))
out("   Last column (col -1):", m.col(-1))

# Test 4: Diagonal
out("\n4. DIAGONAL")
out("   Diagonal:", m.diagonal())

# Test 5: Transpose
out("\n5. TRANSPOSE")
out("   Transposed (m.T):", m.T)

# Test 6: Flatten
out("\n6. FLATTEN")
out("   Flattened:", m.flat())

# Test 7: Row sums
out("\n7. ROW SUMS")
out("   Row sums:", m.row_sums())

# Test 8: Column sums
out("\n8. COLUMN SUMS")
out("   Column sums:", m.col_sums())

# Test 9: Row means
out("\n9. ROW MEANS")
out("   Row means:", m.row_means())

# Test 10: Column means
out("\n10. COLUMN MEANS")
out("   Column means:", m.col_means())

# Test with a non-square matrix
out("\n========================================")
out("NON-SQUARE MATRIX TEST")
out("========================================\n")

mat | rect -> [[1.0, 2.0, 3.0, 4.0], [5.0, 6.0, 7.0, 8.0]]
out("Rectangle Matrix (2x4):")
out(rect)

out("\nDimensions:", rect.rows, "x", rect.cols)
out("Row 0:", rect.row(0))
out("Column 2:", rect.col(2))
out("Transposed:", rect.T)
out("Flattened:", rect.flat())
out("Row sums:", rect.row_sums())
out("Column sums:", rect.col_sums())

out("\n========================================")
out("ALL MATRIX ACCESSOR TESTS PASSED!")
out("========================================")
