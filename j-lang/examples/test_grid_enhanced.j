# Test enhanced Grid operations

# Create a grid
grid | g -> [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

out("Grid:")
out(g)

out("Rows:")
out(g.rows)
out("Cols:")
out(g.cols)

# 4-directional neighbors (existing)
out("4-directional neighbors of (1,1):")
list | n4 -> g.neighbors(1, 1)
out(n4)

# 8-directional neighbors (new)
out("8-directional neighbors of (1,1):")
list | n8 -> g.neighbors8(1, 1)
out(n8)

# Find all occurrences of a value
out("Find all 5s:")
list | fives -> g.find_all(5)
out(fives)

# Get specific row
out("Row 1:")
list | row1 -> g.row(1)
out(row1)

# Get specific column
out("Column 2:")
list | col2 -> g.col(2)
out(col2)

out("Grid enhancements test complete!")
