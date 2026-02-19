# Test patterns

out("Test 1: Prefix Sum")
list | nums -> [1, 2, 3, 4, 5]
list | prefix -> prefix_sum(nums)
out("Prefix:", prefix)
out("")

out("Test 2: Two Sum")
list | arr -> [2, 7, 11, 15]
list | indices -> two_sum_indices(arr, 9)
out("Indices:", indices)
out("")

out("Test 3: Three Sum")
list | nums3 -> [-1, 0, 1, 2, -1, -4]
list | triplets -> three_sum(nums3, 0)
out("Triplets:", triplets)
out("")

out("Done!")


out("Test 4: Max Sliding Window")
list | window_arr -> [1, 3, -1, -3, 5, 3, 6, 7]
list | max_vals -> max_sliding_window(window_arr, 3)
out("Max values:", max_vals)
out("")

out("Test 5: LIS")
list | lis_arr -> [10, 9, 2, 5, 3, 7, 101, 18]
int | lis_length -> longest_increasing_subsequence(lis_arr)
out("LIS length:", lis_length)
out("")

out("Test 6: Merge Intervals")
list | int1 -> [1, 3]
list | int2 -> [2, 6]
list | int3 -> [8, 10]
list | int4 -> [15, 18]
list | intervals -> [int1, int2, int3, int4]
list | merged -> merge_intervals(intervals)
out("Merged:", merged)
out("")

out("All tests passed!")
