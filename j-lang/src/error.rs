// Enhanced error messaging system with helpful tips and solutions

use std::fmt;

#[allow(dead_code)]
#[derive(Debug, Clone)]
pub struct JError {
    pub kind: ErrorKind,
    pub message: String,
    pub line: Option<usize>,
    pub column: Option<usize>,
    pub source_line: Option<String>,
    pub tip: Option<String>,
    pub solution: Option<String>,
}

#[allow(dead_code)]
#[derive(Debug, Clone, PartialEq)]
pub enum ErrorKind {
    // Lexer errors
    UnexpectedCharacter,
    UnterminatedString,
    InvalidNumber,
    InvalidEscape,
    
    // Parser errors
    UnexpectedToken,
    ExpectedToken,
    InvalidSyntax,
    MissingOperand,
    
    // Runtime errors
    UndefinedVariable,
    TypeError,
    DivisionByZero,
    IndexOutOfBounds,
    KeyNotFound,
    InvalidOperation,
    StackOverflow,
    
    // Function errors
    UndefinedFunction,
    WrongArgumentCount,
    InvalidArgument,
    
    // Other
    FileNotFound,
    IOError,
}

impl JError {
    pub fn new(kind: ErrorKind, message: String) -> Self {
        Self {
            kind,
            message,
            line: None,
            column: None,
            source_line: None,
            tip: None,
            solution: None,
        }
    }
    
    pub fn with_location(mut self, line: usize, column: usize) -> Self {
        self.line = Some(line);
        self.column = Some(column);
        self
    }
    
    #[allow(dead_code)]
    pub fn with_source(mut self, source_line: String) -> Self {
        self.source_line = Some(source_line);
        self
    }
    
    pub fn with_tip(mut self, tip: String) -> Self {
        self.tip = Some(tip);
        self
    }
    
    pub fn with_solution(mut self, solution: String) -> Self {
        self.solution = Some(solution);
        self
    }
    
    // Smart error constructors with automatic tips and solutions
    
    pub fn undefined_variable(name: &str, line: usize, column: usize) -> Self {
        let similar = suggest_similar_name(name);
        let mut error = Self::new(
            ErrorKind::UndefinedVariable,
            format!("Variable '{}' is not defined", name)
        ).with_location(line, column);
        
        if let Some(suggestion) = similar {
            error = error.with_tip(format!("Did you mean '{}'?", suggestion));
        } else {
            error = error.with_tip("Make sure you've declared this variable before using it".to_string());
        }
        
        error = error.with_solution(format!(
            "Declare the variable first:\n  int | {} -> 0\nor check for typos in the variable name",
            name
        ));
        
        error
    }
    
    pub fn undefined_function(name: &str, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::UndefinedFunction,
            format!("Function '{}' is not defined", name)
        ).with_location(line, column);
        
        error = error.with_tip("Check if the function name is spelled correctly".to_string());
        error = error.with_solution(format!(
            "Define the function first:\n  fn | {}(params) > {{\n    // function body\n  }}",
            name
        ));
        
        error
    }
    
    #[allow(dead_code)]
    pub fn type_error(expected: &str, got: &str, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::TypeError,
            format!("Type mismatch: expected {}, got {}", expected, got)
        ).with_location(line, column);
        
        error = error.with_tip(format!("The operation requires a {} value", expected));
        
        // Provide conversion suggestions
        let conversion_tip = match (expected, got) {
            ("int", "float") => Some("Use int(value) to convert float to int"),
            ("float", "int") => Some("Use float(value) to convert int to float"),
            ("str", _) => Some("Use str(value) to convert to string"),
            ("list", "str") => Some("Use list(value) to convert string to list of characters"),
            _ => None,
        };
        
        if let Some(tip) = conversion_tip {
            error = error.with_solution(tip.to_string());
        }
        
        error
    }
    
    #[allow(dead_code)]
    pub fn wrong_argument_count(func_name: &str, expected: usize, got: usize, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::WrongArgumentCount,
            format!("Function '{}' expects {} argument(s), but {} were provided", func_name, expected, got)
        ).with_location(line, column);
        
        if got < expected {
            error = error.with_tip(format!("Add {} more argument(s) to the function call", expected - got));
        } else {
            error = error.with_tip(format!("Remove {} argument(s) from the function call", got - expected));
        }
        
        error = error.with_solution(format!(
            "Check the function definition to see what arguments it expects"
        ));
        
        error
    }
    
    pub fn division_by_zero(line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::DivisionByZero,
            "Cannot divide by zero".to_string()
        ).with_location(line, column);
        
        error = error.with_tip("Check if the divisor could be zero".to_string());
        error = error.with_solution(
            "Add a check before division:\n  if divisor != 0 {\n    result = numerator / divisor\n  }".to_string()
        );
        
        error
    }
    
    pub fn index_out_of_bounds(index: i64, length: usize, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::IndexOutOfBounds,
            format!("Index {} is out of bounds for list of length {}", index, length)
        ).with_location(line, column);
        
        error = error.with_tip(format!("Valid indices are 0 to {}", length.saturating_sub(1)));
        error = error.with_solution(
            "Check the index before accessing:\n  if index < len(list) {\n    value = list[index]\n  }".to_string()
        );
        
        error
    }
    
    pub fn key_not_found(key: &str, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::KeyNotFound,
            format!("Key '{}' not found in dictionary", key)
        ).with_location(line, column);
        
        error = error.with_tip("Check if the key exists before accessing it".to_string());
        error = error.with_solution(format!(
            "Use the 'in' operator to check:\n  if \"{}\" in dict {{\n    value = dict[\"{}\"]\n  }}",
            key, key
        ));
        
        error
    }
    
    pub fn unexpected_token(expected: &str, got: &str, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::UnexpectedToken,
            format!("Expected {}, but got {}", expected, got)
        ).with_location(line, column);
        
        error = error.with_tip(format!("Add {} here", expected));
        
        // Provide syntax-specific solutions
        let solution = match expected {
            "'->' after variable name" => "Variable declarations use: type | name -> value",
            "'|' after type" => "Variable declarations use: type | name -> value",
            "')' after parameters" => "Function declarations use: fn | name(params) > { body }",
            "'>' before function body" => "Function declarations use: fn | name(params) > { body }",
            _ => "Check the J-Lang syntax guide for correct syntax",
        };
        
        error = error.with_solution(solution.to_string());
        
        error
    }
    
    pub fn unterminated_string(line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::UnterminatedString,
            "String literal is not terminated".to_string()
        ).with_location(line, column);
        
        error = error.with_tip("Add a closing quote (\") to end the string".to_string());
        error = error.with_solution("Strings must be enclosed in double quotes: \"text\"".to_string());
        
        error
    }
    
    #[allow(dead_code)]
    pub fn invalid_syntax(context: &str, line: usize, column: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::InvalidSyntax,
            format!("Invalid syntax in {}", context)
        ).with_location(line, column);
        
        error = error.with_tip("Review the syntax for this construct".to_string());
        
        let solution = match context {
            "variable declaration" => "Use: type | name -> value\nExample: int | x -> 42",
            "function declaration" => "Use: fn | name(type|param) > { body }\nExample: fn | add(int|a, int|b) > { return a + b }",
            "for loop" => "Use: for var in iterable { body }\nExample: for i in 0..10 { out(i) }",
            "if statement" => "Use: if condition { body }\nExample: if x > 0 { out(\"positive\") }",
            _ => "Check the J-Lang documentation for correct syntax",
        };
        
        error = error.with_solution(solution.to_string());
        
        error
    }
    
    pub fn stack_overflow(depth: usize) -> Self {
        let mut error = Self::new(
            ErrorKind::StackOverflow,
            format!("Stack overflow: too many recursive calls (depth: {})", depth)
        );
        
        error = error.with_tip("Your function is calling itself too many times".to_string());
        error = error.with_solution(
            "Add a base case to stop recursion:\n  fn | factorial(int|n) > {\n    if n <= 1 { return 1 }\n    return n * factorial(n - 1)\n  }".to_string()
        );
        
        error
    }
}

impl fmt::Display for JError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        // Error header with emoji
        let emoji = match self.kind {
            ErrorKind::UnexpectedCharacter | ErrorKind::UnexpectedToken => "❌",
            ErrorKind::UndefinedVariable | ErrorKind::UndefinedFunction => "🔍",
            ErrorKind::TypeError => "🔧",
            ErrorKind::DivisionByZero | ErrorKind::IndexOutOfBounds => "⚠️",
            ErrorKind::StackOverflow => "💥",
            _ => "❗",
        };
        
        writeln!(f, "\n{} Error: {}", emoji, self.message)?;
        
        // Location information
        if let (Some(line), Some(column)) = (self.line, self.column) {
            writeln!(f, "  ╭─ at line {}, column {}", line, column)?;
            
            // Show source line with pointer
            if let Some(ref source) = self.source_line {
                writeln!(f, "  │")?;
                writeln!(f, "{:3} │ {}", line, source)?;
                writeln!(f, "  │ {}^", " ".repeat(column))?;
            }
        }
        
        // Tip section
        if let Some(ref tip) = self.tip {
            writeln!(f, "  │")?;
            writeln!(f, "  ├─ 💡 Tip: {}", tip)?;
        }
        
        // Solution section
        if let Some(ref solution) = self.solution {
            writeln!(f, "  │")?;
            writeln!(f, "  ├─ ✅ Solution:")?;
            for line in solution.lines() {
                writeln!(f, "  │    {}", line)?;
            }
        }
        
        writeln!(f, "  ╰─")?;
        
        Ok(())
    }
}

// Helper function to suggest similar variable names (simple Levenshtein distance)
fn suggest_similar_name(name: &str) -> Option<String> {
    // This would ideally check against known variables in scope
    // For now, we'll suggest common typos
    let common_vars = vec!["i", "j", "k", "x", "y", "z", "count", "index", "value", "result", "temp"];
    
    let mut best_match = None;
    let mut best_distance = usize::MAX;
    
    for var in common_vars {
        let distance = levenshtein_distance(name, var);
        if distance < best_distance && distance <= 2 {
            best_distance = distance;
            best_match = Some(var.to_string());
        }
    }
    
    best_match
}

// Simple Levenshtein distance implementation
fn levenshtein_distance(s1: &str, s2: &str) -> usize {
    let len1 = s1.len();
    let len2 = s2.len();
    let mut matrix = vec![vec![0; len2 + 1]; len1 + 1];
    
    for i in 0..=len1 {
        matrix[i][0] = i;
    }
    for j in 0..=len2 {
        matrix[0][j] = j;
    }
    
    for (i, c1) in s1.chars().enumerate() {
        for (j, c2) in s2.chars().enumerate() {
            let cost = if c1 == c2 { 0 } else { 1 };
            matrix[i + 1][j + 1] = std::cmp::min(
                std::cmp::min(
                    matrix[i][j + 1] + 1,
                    matrix[i + 1][j] + 1
                ),
                matrix[i][j] + cost
            );
        }
    }
    
    matrix[len1][len2]
}

// Convert string errors to JError
impl From<String> for JError {
    fn from(s: String) -> Self {
        // Try to parse error messages and enhance them
        if s.contains("not defined") || s.contains("not found") {
            if let Some(name) = extract_identifier(&s) {
                if s.contains("Variable") {
                    return JError::undefined_variable(&name, 0, 0);
                } else if s.contains("Function") {
                    return JError::undefined_function(&name, 0, 0);
                }
            }
        }
        
        if s.contains("divide by zero") || s.contains("division by zero") {
            return JError::division_by_zero(0, 0);
        }
        
        if s.contains("Stack overflow") {
            return JError::stack_overflow(50);
        }
        
        // Default error
        JError::new(ErrorKind::InvalidOperation, s)
    }
}

fn extract_identifier(s: &str) -> Option<String> {
    // Extract identifier from error message like "Variable 'x' not defined"
    if let Some(start) = s.find('\'') {
        if let Some(end) = s[start + 1..].find('\'') {
            return Some(s[start + 1..start + 1 + end].to_string());
        }
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_undefined_variable_error() {
        let error = JError::undefined_variable("count", 5, 10);
        assert_eq!(error.kind, ErrorKind::UndefinedVariable);
        assert!(error.tip.is_some());
        assert!(error.solution.is_some());
    }
    
    #[test]
    fn test_type_error() {
        let error = JError::type_error("int", "str", 3, 5);
        assert_eq!(error.kind, ErrorKind::TypeError);
        assert!(error.tip.is_some());
    }
    
    #[test]
    fn test_levenshtein_distance() {
        assert_eq!(levenshtein_distance("count", "cont"), 1);
        assert_eq!(levenshtein_distance("index", "indx"), 1);
        assert_eq!(levenshtein_distance("hello", "world"), 4);
    }
}
