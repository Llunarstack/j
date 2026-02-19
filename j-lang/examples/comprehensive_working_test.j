# COMPREHENSIVE TEST OF ALL BUILT-IN FUNCTIONS
out("========================================")
out("TESTING ALL BUILT-IN FUNCTIONS")
out("========================================")

int | test_count -> 0

# BASIC I/O & UTILITIES
out("\n=== BASIC I/O & UTILITIES ===")
test_count = test_count + 1
out(test_count, ". out: works")

test_count = test_count + 1
out(test_count, ". varType:", varType(42))

test_count = test_count + 1
out(test_count, ". len:", len([1, 2, 3]))

# MATH FUNCTIONS
out("\n=== MATH FUNCTIONS ===")
test_count = test_count + 1
out(test_count, ". abs:", abs(-5))

test_count = test_count + 1
out(test_count, ". sqrt:", sqrt(16))

test_count = test_count + 1
out(test_count, ". pow:", pow(2, 10))

test_count = test_count + 1
out(test_count, ". gcd:", gcd(48, 18))

test_count = test_count + 1
out(test_count, ". lcm:", lcm(12, 18))

test_count = test_count + 1
out(test_count, ". is_prime:", is_prime(17))

test_count = test_count + 1
out(test_count, ". factorial:", factorial(5))

test_count = test_count + 1
out(test_count, ". fibonacci:", fibonacci(10))

# LIST OPERATIONS
out("\n=== LIST OPERATIONS ===")
list | test_list -> [1, 2, 3, 4, 5]

test_count = test_count + 1
out(test_count, ". push:", push(test_list, 6))

test_count = test_count + 1
out(test_count, ". pop:", pop(test_list))

test_count = test_count + 1
out(test_count, ". reverse:", reverse(test_list))

test_count = test_count + 1
out(test_count, ". sort:", sort([5, 2, 8, 1, 9]))

test_count = test_count + 1
out(test_count, ". sum:", sum(test_list))

test_count = test_count + 1
out(test_count, ". min:", min(test_list))

test_count = test_count + 1
out(test_count, ". max:", max(test_list))

test_count = test_count + 1
out(test_count, ". unique:", unique([1, 2, 2, 3, 3, 4]))

test_count = test_count + 1
out(test_count, ". flatten:", flatten([[1, 2], [3, 4]]))

test_count = test_count + 1
out(test_count, ". swap:", swap([1, 2, 3, 4], 1, 3))

test_count = test_count + 1
out(test_count, ". rotate_left:", rotate_left([1, 2, 3, 4, 5], 2))

test_count = test_count + 1
out(test_count, ". rotate_right:", rotate_right([1, 2, 3, 4, 5], 2))

# FUNCTIONAL PROGRAMMING
out("\n=== FUNCTIONAL PROGRAMMING ===")
test_count = test_count + 1
out(test_count, ". map:", map([1, 2, 3], |x| x * 2))

test_count = test_count + 1
out(test_count, ". filter:", filter([1, 2, 3, 4, 5], |x| x > 2))

test_count = test_count + 1
out(test_count, ". reduce:", reduce([1, 2, 3, 4, 5], 0, |acc, x| acc + x))

test_count = test_count + 1
out(test_count, ". count_if:", count_if([1, 2, 3, 4, 5], |x| x % 2 == 0))

test_count = test_count + 1
out(test_count, ". find_index:", find_index([1, 2, 3, 4, 5], |x| x > 3))

test_count = test_count + 1
out(test_count, ". all:", all([1, 2, 3, 4, 5], |x| x > 0))

test_count = test_count + 1
out(test_count, ". any:", any([1, 2, 3, 4, 5], |x| x > 3))

test_count = test_count + 1
out(test_count, ". partition:", partition([1, 2, 3, 4, 5, 6], |x| x % 2 == 0))

# ITERATORS & SEQUENCES
out("\n=== ITERATORS & SEQUENCES ===")
test_count = test_count + 1
out(test_count, ". range(5):", range(5))

test_count = test_count + 1
out(test_count, ". range(2, 7):", range(2, 7))

test_count = test_count + 1
out(test_count, ". enumerate:", enumerate([10, 20, 30]))

test_count = test_count + 1
out(test_count, ". zip:", zip([1, 2, 3], [4, 5, 6]))

test_count = test_count + 1
out(test_count, ". chain:", chain([1, 2], [3, 4]))

test_count = test_count + 1
out(test_count, ". repeat:", repeat(5, 3))

test_count = test_count + 1
out(test_count, ". take:", take([1, 2, 3, 4, 5], 3))

test_count = test_count + 1
out(test_count, ". drop:", drop([1, 2, 3, 4, 5], 2))

test_count = test_count + 1
out(test_count, ". chunk:", chunk([1, 2, 3, 4, 5, 6], 2))

test_count = test_count + 1
out(test_count, ". sliding_window:", sliding_window([1, 2, 3, 4, 5], 3))

test_count = test_count + 1
out(test_count, ". pairwise:", pairwise([1, 2, 3, 4, 5]))

test_count = test_count + 1
out(test_count, ". batched:", batched([1, 2, 3, 4, 5, 6], 2))

# PYTHON-STYLE FUNCTIONS
out("\n=== PYTHON-STYLE FUNCTIONS ===")
test_count = test_count + 1
out(test_count, ". take_while:", take_while([1, 2, 3, 4, 5], |x| x < 4))

test_count = test_count + 1
out(test_count, ". drop_while:", drop_while([1, 2, 3, 4, 5], |x| x < 3))

test_count = test_count + 1
out(test_count, ". scan:", scan([1, 2, 3, 4, 5], 0, |acc, x| acc + x))

test_count = test_count + 1
out(test_count, ". accumulate:", accumulate([1, 2, 3, 4, 5]))

test_count = test_count + 1
out(test_count, ". frequencies:", frequencies(["a", "b", "a", "c", "b"]))

test_count = test_count + 1
out(test_count, ". dedupe:", dedupe([1, 1, 2, 2, 3, 1]))

test_count = test_count + 1
out(test_count, ". compact:", compact([1, 2, 3, 4]))

test_count = test_count + 1
out(test_count, ". parallel_map:", parallel_map([1, 2, 3], |x| x * x))

test_count = test_count + 1
out(test_count, ". deep_clone:", deep_clone([1, 2, 3]))

# STRING OPERATIONS
out("\n=== STRING OPERATIONS ===")
test_count = test_count + 1
out(test_count, ". upper:", upper("hello"))

test_count = test_count + 1
out(test_count, ". lower:", lower("HELLO"))

test_count = test_count + 1
out(test_count, ". trim:", trim("  hello  "))

test_count = test_count + 1
out(test_count, ". split:", split("a,b,c", ","))

test_count = test_count + 1
out(test_count, ". join:", join(["a", "b", "c"], ","))

test_count = test_count + 1
out(test_count, ". replace:", replace("hello", "l", "L"))

test_count = test_count + 1
out(test_count, ". starts_with:", starts_with("hello", "he"))

test_count = test_count + 1
out(test_count, ". ends_with:", ends_with("hello", "lo"))

test_count = test_count + 1
out(test_count, ". substring:", substring("hello", 1, 4))

# SET OPERATIONS
out("\n=== SET OPERATIONS ===")
test_count = test_count + 1
out(test_count, ". union:", union([1, 2, 3], [3, 4, 5]))

test_count = test_count + 1
out(test_count, ". intersect:", intersect([1, 2, 3], [2, 3, 4]))

test_count = test_count + 1
out(test_count, ". difference:", difference([1, 2, 3], [2, 3]))

test_count = test_count + 1
out(test_count, ". symmetric_diff:", symmetric_diff([1, 2, 3], [2, 3, 4]))

# DICT OPERATIONS
out("\n=== DICT OPERATIONS ===")
dict | test_dict -> {"a": 1, "b": 2, "c": 3}

test_count = test_count + 1
out(test_count, ". keys:", keys(test_dict))

test_count = test_count + 1
out(test_count, ". values:", values(test_dict))

test_count = test_count + 1
out(test_count, ". items:", items(test_dict))

test_count = test_count + 1
out(test_count, ". has:", has(test_dict, "a"))

test_count = test_count + 1
out(test_count, ". get:", get(test_dict, "a", 0))

# SEARCH & SORT
out("\n=== SEARCH & SORT ===")
list | sorted_list -> [1, 3, 5, 7, 9, 11, 13]

test_count = test_count + 1
out(test_count, ". binary_search:", binary_search(sorted_list, 7))

test_count = test_count + 1
out(test_count, ". is_sorted:", is_sorted(sorted_list))

test_count = test_count + 1
out(test_count, ". shuffle:", shuffle([1, 2, 3, 4, 5]))

test_count = test_count + 1
out(test_count, ". sample:", sample([1, 2, 3, 4, 5], 3))

# LEETCODE PATTERNS
out("\n=== LEETCODE PATTERNS ===")
list | nums -> [1, 2, 3, 4, 5]
list | prefix -> prefix_sum(nums)

test_count = test_count + 1
out(test_count, ". prefix_sum:", prefix)

test_count = test_count + 1
out(test_count, ". range_sum:", range_sum(prefix, 1, 3))

test_count = test_count + 1
out(test_count, ". two_sum_indices:", two_sum_indices([2, 7, 11, 15], 9))

test_count = test_count + 1
out(test_count, ". three_sum:", three_sum([-1, 0, 1, 2, -1, -4], 0))

test_count = test_count + 1
out(test_count, ". max_sliding_window:", max_sliding_window([1, 3, -1, -3, 5, 3, 6, 7], 3))

test_count = test_count + 1
out(test_count, ". longest_increasing_subsequence:", longest_increasing_subsequence([10, 9, 2, 5, 3, 7]))

list | i1 -> [1, 3]
list | i2 -> [2, 6]
list | intervals -> [i1, i2]

test_count = test_count + 1
out(test_count, ". merge_intervals:", merge_intervals(intervals))

dict | graph -> {"A": ["B"], "B": ["C"], "C": []}

test_count = test_count + 1
out(test_count, ". topological_sort:", topological_sort(graph))

# GRAPH OPERATIONS
out("\n=== GRAPH OPERATIONS ===")
graph | g -> {}
g = add_node(g, "A")
g = add_node(g, "B")
g = add_edge(g, "A", "B", 1)

test_count = test_count + 1
out(test_count, ". add_node/add_edge: works")

test_count = test_count + 1
out(test_count, ". get_neighbors:", get_neighbors(g, "A"))

test_count = test_count + 1
out(test_count, ". bfs:", bfs(g, "A"))

test_count = test_count + 1
out(test_count, ". dfs:", dfs(g, "A"))

# ADVANCED FEATURES
out("\n=== ADVANCED FEATURES ===")
test_count = test_count + 1
out(test_count, ". tap:", tap([1, 2, 3], "test"))

test_count = test_count + 1
out(test_count, ". pipe:", pipe([1, 2, 3], |x| map(x, |n| n * 2)))

test_count = test_count + 1
int | retried -> retry(|| 42, 3)
out(test_count, ". retry:", retried)

# VECTOR/MATRIX OPERATIONS
out("\n=== VECTOR/MATRIX ===")
test_count = test_count + 1
out(test_count, ". dot:", dot([1, 2, 3], [4, 5, 6]))

test_count = test_count + 1
out(test_count, ". magnitude:", magnitude([3, 4]))

test_count = test_count + 1
out(test_count, ". normalize:", normalize([3, 4]))

test_count = test_count + 1
out(test_count, ". transpose:", transpose([[1, 2], [3, 4]]))

test_count = test_count + 1
out(test_count, ". identity:", identity(3))

test_count = test_count + 1
out(test_count, ". zeros:", zeros(3))

test_count = test_count + 1
out(test_count, ". ones:", ones(3))

# STRING ALGORITHMS
out("\n=== STRING ALGORITHMS ===")
test_count = test_count + 1
out(test_count, ". levenshtein:", levenshtein("kitten", "sitting"))

test_count = test_count + 1
out(test_count, ". hamming:", hamming("karolin", "kathrin"))

# UTILITY FUNCTIONS
out("\n=== UTILITY FUNCTIONS ===")
test_count = test_count + 1
out(test_count, ". now:", now())

test_count = test_count + 1
out(test_count, ". random:", random())

test_count = test_count + 1
out(test_count, ". type_of:", type_of(42))

test_count = test_count + 1
out(test_count, ". json_stringify:", json_stringify([1, 2, 3]))

# COMBINATORICS
out("\n=== COMBINATORICS ===")
test_count = test_count + 1
out(test_count, ". permutations:", permutations([1, 2, 3], 2))

test_count = test_count + 1
out(test_count, ". combinations:", combinations([1, 2, 3, 4], 2))

test_count = test_count + 1
out(test_count, ". product:", product([1, 2], [3, 4]))

# ADVANCED LIST OPERATIONS
out("\n=== ADVANCED LIST OPS ===")
test_count = test_count + 1
out(test_count, ". interleave:", interleave([1, 2], [10, 20]))

test_count = test_count + 1
out(test_count, ". zip_longest:", zip_longest([1, 2, 3], [4, 5], 0))

test_count = test_count + 1
out(test_count, ". cycle:", cycle([1, 2, 3], 2))

test_count = test_count + 1
out(test_count, ". rotate:", rotate([1, 2, 3, 4, 5], 2))

# FORMATTING
out("\n=== FORMATTING ===")
test_count = test_count + 1
out(test_count, ". pad_left:", pad_left("test", 10))

test_count = test_count + 1
out(test_count, ". pad_right:", pad_right("test", 10))

out("\n========================================")
out("TOTAL TESTS:", test_count)
out("ALL BUILT-IN FUNCTIONS TESTED!")
out("========================================")
