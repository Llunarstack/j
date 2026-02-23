# Analytics Pipeline

A professional demonstration of **advanced J language features**: graphs, deques, priority queues, data pipelines, builtin algorithms, and classes.

## Run

From the `j-lang` crate directory:

```bash
cargo run -- run examples/analytics_pipeline/main.j
```

## Features Demonstrated

| Section | Feature | Description |
|--------|---------|-------------|
| 1 | **Graph** | Task dependency graph with `add_node`, `add_edge`, `get_neighbors`, `bfs`, `dfs` |
| 2 | **Priority Queue** | Job scheduler with `pq_push`, `pq_peek`, `pq_pop` (min-heap by priority) |
| 3 | **Deque** | Double-ended work queue with `push_front`, `push_back`, `peek_front`, `peek_back` |
| 4 | **Data pipeline** | `map` and `filter` with lambdas for transform-and-filter workflows |
| 5 | **Builtin algorithms** | `count_if`, `two_sum_indices`, `prefix_sum`, `range_sum` |
| 6 | **Class** | Simple `Point` class with fields and a `sum()` method |

## Requirements

- J interpreter (this repo, built with `cargo build`).
- No external files or network; all data is in-memory.
