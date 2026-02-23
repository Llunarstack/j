# Analytics Pipeline - Professional demo of J advanced features
# Graph, Deque, Priority Queue, Pipelines, Builtin algorithms

out("========================================")
out("ANALYTICS PIPELINE - Advanced Features")
out("========================================")
out("")

# ---------------------------------------------------------------------------
# 1. Task dependency graph (BFS / DFS)
# ---------------------------------------------------------------------------
out("1. TASK DEPENDENCY GRAPH")
out("   Building graph: A -> B, A -> C, B -> D, C -> D")

graph | g -> {}
g = add_node(g, "A")
g = add_node(g, "B")
g = add_node(g, "C")
g = add_node(g, "D")
g = add_edge(g, "A", "B", 1)
g = add_edge(g, "A", "C", 2)
g = add_edge(g, "B", "D", 3)
g = add_edge(g, "C", "D", 1)

list | neighbors_a -> get_neighbors(g, "A")
out(concat("   Neighbors of A: ", neighbors_a))

list | bfs_order -> bfs(g, "A")
out(concat("   BFS from A: ", bfs_order))

list | dfs_order -> dfs(g, "A")
out(concat("   DFS from A: ", dfs_order))
out("")

# ---------------------------------------------------------------------------
# 2. Priority queue - job scheduler
# ---------------------------------------------------------------------------
out("2. PRIORITY QUEUE (Job Scheduler)")
out("   Lower number = higher priority")

priorityq | pq -> []
pq = pq_push(pq, 3, "Low")
pq = pq_push(pq, 1, "High")
pq = pq_push(pq, 2, "Medium")

list | peek_val -> pq_peek(pq)
out(concat("   Peek (next job): ", peek_val))

list | popped -> pq_pop(pq)
out(concat("   Pop 1: ", popped))

list | popped2 -> pq_pop(pq)
out(concat("   Pop 2: ", popped2))
out("")

# ---------------------------------------------------------------------------
# 3. Deque - work queue
# ---------------------------------------------------------------------------
out("3. DEQUE (Work Queue)")

deque | work -> [100, 200]
work = push_front(work, 50)
work = push_back(work, 300)

list | front_val -> peek_front(work)
out(concat("   Peek front: ", front_val))

list | back_val -> peek_back(work)
out(concat("   Peek back: ", back_val))
out(concat("   Deque: ", work))
out("")

# ---------------------------------------------------------------------------
# 4. Data pipeline (map + filter)
# ---------------------------------------------------------------------------
out("4. DATA PIPELINE (map + filter)")

list | raw -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
list | doubled -> map(raw, |x| x * 2)
list | filtered -> filter(doubled, |x| x > 10)

out(concat("   Raw: ", raw))
out(concat("   After map (*2): ", doubled))
out(concat("   After filter (>10): ", filtered))
out("")

# ---------------------------------------------------------------------------
# 5. Builtin algorithms
# ---------------------------------------------------------------------------
out("5. BUILTIN ALGORITHMS")

list | nums -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
int | evens -> count_if(nums, |x| x % 2 == 0)
out(concat("   count_if(even): ", evens))

list | arr -> [2, 7, 11, 15]
list | indices -> two_sum_indices(arr, 9)
out(concat("   two_sum_indices([2,7,11,15], 9): ", indices))

list | vals -> [1, 2, 3, 4, 5]
list | prefix -> prefix_sum(vals)
out(concat("   prefix_sum([1..5]): ", prefix))

int | range_total -> range_sum(prefix, 1, 3)
out(concat("   range_sum(prefix, 1, 3): ", range_total))
out("")

# ---------------------------------------------------------------------------
# 6. Class - simple value type
# ---------------------------------------------------------------------------
out("6. CLASS (Point)")

class | Point {
  int | x -> 4
  int | y -> 3
  fn | sum () > x + y
}

out("   Point defined: x=4, y=3, sum() = x+y")
out("")

out("========================================")
out("ANALYTICS PIPELINE COMPLETE")
out("========================================")
