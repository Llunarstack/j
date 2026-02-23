//! J Programming Language — core library.
//!
//! This crate provides the lexer, parser, interpreter, and tooling for the J language.
//! The `j` binary uses this library for REPL, run, build, check, and jolt commands.

pub mod compiler;
pub mod crypto;
pub mod error;
pub mod interpreter;
pub mod jit;
pub mod jolt;
pub mod lexer;
pub mod parser;
pub mod repl;
pub mod runtime;

// Re-export main types for consumers of the library
pub use error::JError;
pub use interpreter::Interpreter;
pub use lexer::{Lexer, Token, TokenType};
pub use parser::Parser;
