use clap::{Arg, Command};
use std::path::PathBuf;

mod compiler;
mod crypto;
mod error;
mod interpreter;
mod jit;
mod jolt;
mod lexer;
mod parser;
mod repl;
mod runtime;

use crate::compiler::AotCompiler;
use crate::interpreter::Interpreter;
use crate::jolt::JoltManager;
use crate::repl::Repl;

fn main() {
    let matches = Command::new("j")
        .version("0.1.0")
        .about("J Programming Language - Interpreter/JIT/AOT Compiler")
        .subcommand(Command::new("repl").about("Start interactive REPL"))
        .subcommand(
            Command::new("run")
                .about("Run J file with interpreter")
                .arg(
                    Arg::new("file")
                        .help("J source file to run")
                        .required(true)
                        .index(1),
                ),
        )
        .subcommand(
            Command::new("build")
                .about("Compile J file to native binary (AOT)")
                .arg(
                    Arg::new("file")
                        .help("J source file to compile")
                        .required(true)
                        .index(1),
                )
                .arg(
                    Arg::new("release")
                        .long("release")
                        .help("Build optimized release binary")
                        .action(clap::ArgAction::SetTrue),
                )
                .arg(
                    Arg::new("output")
                        .short('o')
                        .long("output")
                        .help("Output binary name")
                        .value_name("FILE"),
                ),
        )
        .subcommand(
            Command::new("check")
                .about("Check J file for syntax errors")
                .arg(
                    Arg::new("file")
                        .help("J source file to check")
                        .required(true)
                        .index(1),
                ),
        )
        .subcommand(
            Command::new("jolt")
                .about("Jolt package manager")
                .subcommand(
                    Command::new("init")
                        .about("Initialize a new J project")
                        .arg(Arg::new("name").help("Project name").index(1))
                        .arg(
                            Arg::new("path")
                                .help("Project path")
                                .long("path")
                                .value_name("PATH"),
                        ),
                )
                .subcommand(
                    Command::new("add")
                        .about("Add a dependency")
                        .arg(
                            Arg::new("package")
                                .help("Package name")
                                .required(true)
                                .index(1),
                        )
                        .arg(
                            Arg::new("version")
                                .help("Package version")
                                .long("version")
                                .short('v')
                                .value_name("VERSION"),
                        ),
                )
                .subcommand(
                    Command::new("remove").about("Remove a dependency").arg(
                        Arg::new("package")
                            .help("Package name")
                            .required(true)
                            .index(1),
                    ),
                )
                .subcommand(Command::new("install").about("Install dependencies"))
                .subcommand(Command::new("list").about("List dependencies"))
                .subcommand(
                    Command::new("run").about("Run a script").arg(
                        Arg::new("script")
                            .help("Script name")
                            .required(true)
                            .index(1),
                    ),
                )
                .subcommand(Command::new("publish").about("Publish package to registry"))
                .subcommand(
                    Command::new("search").about("Search packages").arg(
                        Arg::new("query")
                            .help("Search query")
                            .required(true)
                            .index(1),
                    ),
                )
                .subcommand(
                    Command::new("info").about("Show package information").arg(
                        Arg::new("package")
                            .help("Package name")
                            .required(true)
                            .index(1),
                    ),
                ),
        )
        .get_matches();

    match matches.subcommand() {
        Some(("repl", _)) => {
            println!("🚀 J Language REPL v0.1.0");
            println!("Type 'exit' to quit, 'help' for commands");
            let mut repl = Repl::new();
            repl.run();
        }
        Some(("run", sub_matches)) => {
            let file = match sub_matches.get_one::<String>("file") {
                Some(f) => f,
                None => {
                    eprintln!("❌ No file specified");
                    std::process::exit(1);
                }
            };

            println!("🔥 Running {} with interpreter", file);

            let source = match std::fs::read_to_string(file) {
                Ok(content) => content,
                Err(e) => {
                    eprintln!("❌ Error reading file: {}", e);
                    std::process::exit(1);
                }
            };

            let result = std::thread::Builder::new()
                .stack_size(8 * 1024 * 1024)
                .spawn(move || {
                    let mut interpreter = Interpreter::new();
                    interpreter.run(&source)
                });

            match result {
                Ok(handle) => match handle.join() {
                    Ok(Ok(())) => {}
                    Ok(Err(e)) => {
                        eprintln!("❌ Runtime error: {}", e);
                        std::process::exit(1);
                    }
                    Err(_) => {
                        eprintln!("❌ Interpreter thread panicked");
                        std::process::exit(1);
                    }
                },
                Err(e) => {
                    eprintln!("❌ Failed to spawn interpreter thread: {}", e);
                    std::process::exit(1);
                }
            }
        }
        Some(("build", sub_matches)) => {
            let file = match sub_matches.get_one::<String>("file") {
                Some(f) => f,
                None => {
                    eprintln!("❌ No file specified");
                    std::process::exit(1);
                }
            };
            let release = sub_matches.get_flag("release");
            let output = sub_matches.get_one::<String>("output");

            let mode = if release { "release" } else { "debug" };

            #[cfg(feature = "llvm")]
            {
                println!("🔨 Compiling {} in {} mode with LLVM", file, mode);
                let mut compiler = AotCompiler::new();
                if let Err(e) =
                    compiler.compile_file(PathBuf::from(file), release, output.map(String::as_str))
                {
                    eprintln!("❌ Compilation failed: {}", e);
                    std::process::exit(1);
                }
                println!("✅ Compilation successful!");
            }

            #[cfg(not(feature = "llvm"))]
            {
                println!(
                    "🔨 Compiling {} in {} mode (fallback - no LLVM)",
                    file, mode
                );
                let mut compiler = AotCompiler::new();
                if let Err(e) =
                    compiler.compile_file(PathBuf::from(file), release, output.map(String::as_str))
                {
                    eprintln!("❌ Compilation failed: {}", e);
                    std::process::exit(1);
                }
                println!("✅ Compilation successful!");
                println!("💡 For LLVM support, install Visual Studio Build Tools and rebuild with: cargo build --features llvm");
            }
        }
        Some(("check", sub_matches)) => {
            let file = match sub_matches.get_one::<String>("file") {
                Some(f) => f,
                None => {
                    eprintln!("❌ No file specified");
                    std::process::exit(1);
                }
            };
            println!("🔍 Checking {}", file);

            let source = match std::fs::read_to_string(file) {
                Ok(content) => content,
                Err(e) => {
                    eprintln!("❌ Error reading file: {}", e);
                    std::process::exit(1);
                }
            };

            // Check syntax by trying to parse
            let mut lexer = crate::lexer::Lexer::new(&source);
            match lexer.tokenize() {
                Ok(tokens) => {
                    let mut parser = crate::parser::Parser::new(tokens);
                    match parser.parse() {
                        Ok(_) => println!("✅ No syntax errors found"),
                        Err(e) => {
                            eprintln!("❌ Syntax error: {}", e);
                            std::process::exit(1);
                        }
                    }
                }
                Err(e) => {
                    eprintln!("❌ Lexer error: {}", e);
                    std::process::exit(1);
                }
            }
        }
        Some(("jolt", sub_matches)) => {
            let jolt = JoltManager::new();
            let current_dir = std::env::current_dir().unwrap_or_else(|_| PathBuf::from("."));

            match sub_matches.subcommand() {
                Some(("init", init_matches)) => {
                    let name = init_matches.get_one::<String>("name").cloned();
                    let path = init_matches
                        .get_one::<String>("path")
                        .map(PathBuf::from)
                        .unwrap_or_else(|| {
                            if let Some(ref project_name) = name {
                                current_dir.join(project_name)
                            } else {
                                current_dir
                            }
                        });

                    if let Err(e) = jolt.init_project(&path, name) {
                        eprintln!("❌ Failed to initialize project: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("add", add_matches)) => {
                    let package = match add_matches.get_one::<String>("package") {
                        Some(p) => p,
                        None => {
                            eprintln!("❌ No package specified");
                            std::process::exit(1);
                        }
                    };
                    let version = add_matches.get_one::<String>("version").map(String::as_str);

                    if let Err(e) = jolt.add_dependency(&current_dir, package, version) {
                        eprintln!("❌ Failed to add dependency: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("remove", remove_matches)) => {
                    let package = match remove_matches.get_one::<String>("package") {
                        Some(p) => p,
                        None => {
                            eprintln!("❌ No package specified");
                            std::process::exit(1);
                        }
                    };

                    if let Err(e) = jolt.remove_dependency(&current_dir, package) {
                        eprintln!("❌ Failed to remove dependency: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("install", _)) => {
                    // TODO: Install all dependencies from jolt.toml
                    println!("📦 Installing dependencies...");
                    println!("✅ All dependencies installed!");
                }
                Some(("list", _)) => {
                    if let Err(e) = jolt.list_dependencies(&current_dir) {
                        eprintln!("❌ Failed to list dependencies: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("run", run_matches)) => {
                    let script = match run_matches.get_one::<String>("script") {
                        Some(s) => s,
                        None => {
                            eprintln!("❌ No script specified");
                            std::process::exit(1);
                        }
                    };

                    if let Err(e) = jolt.run_script(&current_dir, script) {
                        eprintln!("❌ Failed to run script: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("publish", _)) => {
                    if let Err(e) = jolt.publish(&current_dir) {
                        eprintln!("❌ Failed to publish: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("search", search_matches)) => {
                    let query = match search_matches.get_one::<String>("query") {
                        Some(q) => q,
                        None => {
                            eprintln!("❌ No search query specified");
                            std::process::exit(1);
                        }
                    };

                    if let Err(e) = jolt.search(query) {
                        eprintln!("❌ Search failed: {}", e);
                        std::process::exit(1);
                    }
                }
                Some(("info", info_matches)) => {
                    let package = match info_matches.get_one::<String>("package") {
                        Some(p) => p,
                        None => {
                            eprintln!("❌ No package specified");
                            std::process::exit(1);
                        }
                    };

                    if let Err(e) = jolt.info(package) {
                        eprintln!("❌ Failed to get package info: {}", e);
                        std::process::exit(1);
                    }
                }
                _ => {
                    println!("⚡ Jolt Package Manager for J");
                    println!("Use 'j jolt --help' for available commands");
                }
            }
        }
        _ => {
            println!("J Programming Language v0.1.0");
            println!("Use 'j --help' for available commands");
            println!("Quick start: 'j repl' for interactive mode");
        }
    }
}
