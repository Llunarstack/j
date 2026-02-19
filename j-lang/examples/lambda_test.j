# Test lambda functions
out("Testing lambda functions...")

# Test map with lambda
list | nums -> [1, 2, 3, 4, 5]
out("Original:", nums)

# Try map
list | doubled -> map(nums, |x| x * 2)
out("Doubled:", doubled)

out("Lambda test completed!")
