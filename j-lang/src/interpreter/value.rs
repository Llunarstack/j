use crate::parser::AstNode;
use std::collections::{HashMap, HashSet};
use std::fmt;

/// Control flow for return/break/continue unwinding (reserved for future use).
#[allow(dead_code)]
#[derive(Debug, Clone)]
pub enum ControlFlow {
    None,
    Return(Box<Value>),
    Break,
    Continue,
}

// Define these types before Value enum since Value references them
#[derive(Debug, Clone, PartialEq)]
pub struct TraitMethod {
    pub name: String,
    pub params: Vec<(String, String)>,
    pub return_type: Option<String>,
    pub default_impl: Option<Box<AstNode>>,
}

#[allow(dead_code)]
#[derive(Debug, Clone, PartialEq)]
pub enum FutureState {
    Pending,
    Running,
    Completed,
    Failed(String),
}

#[allow(dead_code)]
#[derive(Debug, Clone, PartialEq)]
pub enum Value {
    Integer(i64),
    Float(f64),
    String(String),
    Boolean(bool),
    Char(char),
    List(Vec<Value>),
    Dict(HashMap<String, Value>),
    Set(HashSet<String>),          // For simplicity, using String keys
    Counter(HashMap<String, i64>), // Frequency counter
    Deque(Vec<Value>),             // Double-ended queue (legacy - use Queue instead)
    PriorityQ(Vec<(i64, Value)>),  // Priority queue (legacy - use Prio instead)
    Graph(HashMap<String, Vec<(String, f64)>>), // Graph: node -> [(neighbor, weight), ...]
    // Security types
    Encrypted {
        ciphertext: Vec<u8>,
        key_id: String,
        nonce: Vec<u8>,
    }, // Encrypted value (auto-decrypt on access)
    Secret(String), // Redacted in logs/errors
    // New OP collection types
    Queue(std::collections::VecDeque<Value>), // Double-ended queue with O(1) push/pop both ends
    Ring {
        buffer: Vec<Value>,
        capacity: usize,
        head: usize,
        size: usize,
    }, // Circular buffer with fixed capacity
    Sorted(Vec<Value>),                       // Auto-sorted list (kept sorted on insert)
    Bag(HashMap<String, i64>),                // Multiset/bag with automatic frequency counting
    Window {
        source: Vec<Value>,
        size: usize,
        start: usize,
    }, // Sliding window view (zero-copy)
    View {
        source: Box<Value>,
        start: usize,
        end: usize,
        mutable: bool,
    }, // Zero-copy slice view
    Prio(Vec<(i64, Value)>),                  // Priority queue (min-heap) - improved version
    Diff(Vec<Value>),                         // Difference list for cheap append
    Tree {
        value: Box<Value>,
        children: Vec<Value>, // Children are also Tree values
    },
    // Advanced array types
    Span {
        source: Box<Value>,
        start: usize,
        end: usize,
    },
    MutSpan {
        source: Box<Value>,
        start: usize,
        end: usize,
    },
    Chunk {
        source: Box<Value>,
        chunk_size: usize,
        current_index: usize,
    },
    Sparse {
        data: HashMap<usize, Value>,
        default: Box<Value>,
        size: usize,
    },
    Function {
        name: String,
        params: Vec<String>,
        body: Box<AstNode>,
    },
    Infinity(bool), // true for +inf, false for -inf
    Emoji(String),
    Money(String, f64), // (currency_symbol, amount)
    Hex(String),
    Date(String),
    Time(String),
    DateTime(String),
    Tuple(Vec<Value>),
    Range(i64, i64, i64),       // start, end, step
    Task(u64),                  // task ID
    Channel(u64),               // channel ID
    Vector(Vec<f64>),           // 1D vector
    Matrix(Vec<Vec<f64>>),      // 2D matrix
    Grid(Vec<Vec<Value>>),      // 2D grid with neighbor logic
    GridNeighbors(Box<Value>),  // callable: grid.neighbors(i, j) -> list of adjacent cell values
    GridNeighbors8(Box<Value>), // callable: grid.neighbors8(i, j) -> 8-directional neighbors
    GridFindAll(Box<Value>),    // callable: grid.find_all(value) -> list of (row, col) positions
    GridRow(Box<Value>),        // callable: grid.row(n) -> list of values in row n
    GridCol(Box<Value>),        // callable: grid.col(n) -> list of values in column n
    MatrixRow(Box<Value>),      // callable: matrix.row(n) -> list of values in row n
    MatrixCol(Box<Value>),      // callable: matrix.col(n) -> list of values in column n
    MatrixDiagonal(Box<Value>), // callable: matrix.diagonal() -> list of diagonal values
    MatrixFlat(Box<Value>),     // callable: matrix.flat() -> flattened list
    MatrixRowSums(Box<Value>),  // callable: matrix.row_sums() -> list of row sums
    MatrixColSums(Box<Value>),  // callable: matrix.col_sums() -> list of column sums
    MatrixRowMeans(Box<Value>), // callable: matrix.row_means() -> list of row means
    MatrixColMeans(Box<Value>), // callable: matrix.col_means() -> list of column means
    Enum {
        name: String,
        variants: HashMap<String, Value>,
    },
    EnumVariant {
        enum_name: String,
        variant_name: String,
        value: Box<Value>,
    },
    Class {
        name: String,
        class_type: Option<String>, // secure, singleton, actor, observable, threadsafe, data, resource
        parent: Option<String>,
        fields: HashMap<String, Value>,
        methods: HashMap<String, Value>,
        static_fields: HashMap<String, Value>,
        static_methods: HashMap<String, Value>,
    },
    Instance {
        class_name: String,
        fields: HashMap<String, Value>,
    },
    /// Constructor function for Class.new() - creates instances
    Constructor(String), // class name
    /// @once decorator: caches first call result
    OnceCached {
        id: usize,
        inner: Box<Value>,
    },
    /// Mirror dispatch: call handle_missing(method_name, args) with this
    MirrorDispatch {
        method_name: String,
        handle_missing: Box<Value>,
    },
    /// Module system - represents a loaded module with exports
    Module {
        name: String,
        path: String,
        exports: HashMap<String, Value>,
    },
    /// Trait system - represents a trait definition
    Trait {
        name: String,
        methods: Vec<TraitMethod>,
    },
    /// Async/Await system - represents a future/promise
    Future {
        id: usize,
        state: FutureState,
        result: Option<Box<Value>>,
    },
    /// Interval type for range problems (start, end)
    Interval(i64, i64),
    None,
}

impl fmt::Display for Value {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Value::Integer(i) => write!(f, "{}", i),
            Value::Float(fl) => write!(f, "{}", fl),
            Value::String(s) => write!(f, "{}", s),
            Value::Boolean(b) => write!(f, "{}", b),
            Value::Char(c) => write!(f, "{}", c),
            Value::List(list) => {
                write!(f, "[")?;
                for (i, item) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::Dict(dict) => {
                write!(f, "{{")?;
                for (i, (key, value)) in dict.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}: {}", key, value)?;
                }
                write!(f, "}}")
            }
            Value::Set(set) => {
                write!(f, "{{")?;
                for (i, item) in set.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "}}")
            }
            Value::Counter(counter) => {
                write!(f, "Counter{{")?;
                for (i, (key, count)) in counter.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}: {}", key, count)?;
                }
                write!(f, "}}")
            }
            Value::Function { name, .. } => write!(f, "<function {}>", name),
            Value::Enum { name, .. } => write!(f, "<enum {}>", name),
            Value::EnumVariant { variant_name, .. } => write!(f, "{}", variant_name),
            Value::Class { name, .. } => write!(f, "<class {}>", name),
            Value::Instance { class_name, .. } => write!(f, "<{} instance>", class_name),
            Value::Constructor(class_name) => write!(f, "<constructor {}>", class_name),
            Value::OnceCached { inner, .. } => write!(f, "<once {}>", inner),
            Value::MirrorDispatch { method_name, .. } => write!(f, "<mirror {}>", method_name),
            Value::GridNeighbors(_) => write!(f, "<grid.neighbors>"),
            Value::GridNeighbors8(_) => write!(f, "<grid.neighbors8>"),
            Value::GridFindAll(_) => write!(f, "<grid.find_all>"),
            Value::GridRow(_) => write!(f, "<grid.row>"),
            Value::GridCol(_) => write!(f, "<grid.col>"),
            Value::MatrixRow(_) => write!(f, "<matrix.row>"),
            Value::MatrixCol(_) => write!(f, "<matrix.col>"),
            Value::MatrixDiagonal(_) => write!(f, "<matrix.diagonal>"),
            Value::MatrixFlat(_) => write!(f, "<matrix.flat>"),
            Value::MatrixRowSums(_) => write!(f, "<matrix.row_sums>"),
            Value::MatrixColSums(_) => write!(f, "<matrix.col_sums>"),
            Value::MatrixRowMeans(_) => write!(f, "<matrix.row_means>"),
            Value::MatrixColMeans(_) => write!(f, "<matrix.col_means>"),
            Value::Infinity(positive) => {
                if *positive {
                    write!(f, "inf")
                } else {
                    write!(f, "-inf")
                }
            }
            Value::Emoji(e) => write!(f, "{}", e),
            Value::Money(symbol, amount) => write!(f, "{}{}", symbol, amount),
            Value::Hex(hex) => write!(f, "{}", hex),
            Value::Date(date) => write!(f, "{}", date),
            Value::Time(time) => write!(f, "{}", time),
            Value::DateTime(datetime) => write!(f, "{}", datetime),
            Value::Tuple(tuple) => {
                write!(f, "(")?;
                for (i, item) in tuple.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, ")")
            }
            Value::Range(start, end, step) => write!(f, "{}..{} by {}", start, end, step),
            Value::Task(id) => write!(f, "<task {}>", id),
            Value::Channel(id) => write!(f, "<channel {}>", id),
            Value::Vector(vec) => {
                write!(f, "vec[")?;
                for (i, item) in vec.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::Matrix(mat) => {
                write!(f, "mat[")?;
                for (i, row) in mat.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "[")?;
                    for (j, item) in row.iter().enumerate() {
                        if j > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{}", item)?;
                    }
                    write!(f, "]")?;
                }
                write!(f, "]")
            }
            Value::Grid(grid) => {
                write!(f, "grid[")?;
                for (i, row) in grid.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "[")?;
                    for (j, item) in row.iter().enumerate() {
                        if j > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{}", item)?;
                    }
                    write!(f, "]")?;
                }
                write!(f, "]")
            }
            Value::Deque(deque) => {
                write!(f, "deque[")?;
                for (i, item) in deque.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::PriorityQ(pq) => {
                write!(f, "priorityq[")?;
                for (i, (priority, value)) in pq.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "({}, {})", priority, value)?;
                }
                write!(f, "]")
            }
            Value::Queue(queue) => {
                write!(f, "queue[")?;
                for (i, item) in queue.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::Ring {
                buffer,
                size,
                head,
                capacity,
            } => {
                write!(f, "ring[")?;
                for i in 0..*size {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    let idx = (*head + i) % *capacity;
                    write!(f, "{}", buffer[idx])?;
                }
                write!(f, "] (capacity: {})", capacity)
            }
            Value::Sorted(list) => {
                write!(f, "sorted[")?;
                for (i, item) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::Bag(bag) => {
                write!(f, "bag{{")?;
                for (i, (key, count)) in bag.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}: {}", key, count)?;
                }
                write!(f, "}}")
            }
            Value::Window {
                source,
                size,
                start,
            } => {
                write!(f, "window[")?;
                let end = (*start + *size).min(source.len());
                for (i, item) in source.iter().enumerate().skip(*start).take(end - *start) {
                    if i > *start {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "] (size: {})", size)
            }
            Value::View {
                source,
                start,
                end,
                mutable,
            } => {
                write!(f, "view[")?;
                if let Value::List(list) = source.as_ref() {
                    for i in *start..*end {
                        if i > *start {
                            write!(f, ", ")?;
                        }
                        if i < list.len() {
                            write!(f, "{}", list[i])?;
                        }
                    }
                }
                write!(f, "]")?;
                if *mutable {
                    write!(f, " (mutable)")
                } else {
                    write!(f, " (immutable)")
                }
            }
            Value::Prio(pq) => {
                write!(f, "prio[")?;
                for (i, (priority, value)) in pq.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "({}, {})", priority, value)?;
                }
                write!(f, "]")
            }
            Value::Diff(list) => {
                write!(f, "diff[")?;
                for (i, item) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", item)?;
                }
                write!(f, "]")
            }
            Value::Span { source, start, end } => {
                write!(f, "span[")?;
                if let Value::List(list) = source.as_ref() {
                    for i in *start..*end {
                        if i > *start {
                            write!(f, ", ")?;
                        }
                        if i < list.len() {
                            write!(f, "{}", list[i])?;
                        }
                    }
                }
                write!(f, "]")
            }
            Value::MutSpan { source, start, end } => {
                write!(f, "mut_span[")?;
                if let Value::List(list) = source.as_ref() {
                    for i in *start..*end {
                        if i > *start {
                            write!(f, ", ")?;
                        }
                        if i < list.len() {
                            write!(f, "{}", list[i])?;
                        }
                    }
                }
                write!(f, "]")
            }
            Value::Chunk {
                source: _,
                chunk_size,
                current_index,
            } => {
                write!(f, "chunk[size={}, index={}]", chunk_size, current_index)
            }
            Value::Sparse {
                data,
                default,
                size,
            } => {
                write!(
                    f,
                    "sparse[size={}, stored={}, default={}]",
                    size,
                    data.len(),
                    default
                )
            }
            Value::Graph(graph) => {
                write!(f, "graph{{")?;
                for (i, (node, edges)) in graph.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}: [", node)?;
                    for (j, (neighbor, weight)) in edges.iter().enumerate() {
                        if j > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "({}, {})", neighbor, weight)?;
                    }
                    write!(f, "]")?;
                }
                write!(f, "}}")
            }
            Value::Encrypted { key_id, .. } => write!(f, "<encrypted:{}>", key_id),
            Value::Secret(_) => write!(f, "[REDACTED]"),
            Value::Tree { value, children } => {
                write!(f, "tree{{value: {}, children: [", value)?;
                for (i, child) in children.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{}", child)?;
                }
                write!(f, "]}}")
            }
            Value::Module { name, .. } => write!(f, "<module {}>", name),
            Value::Trait { name, .. } => write!(f, "<trait {}>", name),
            Value::Future { id, state, .. } => write!(f, "<future {} {:?}>", id, state),
            Value::Interval(start, end) => write!(f, "interval({}, {})", start, end),
            Value::None => write!(f, "none"),
        }
    }
}
