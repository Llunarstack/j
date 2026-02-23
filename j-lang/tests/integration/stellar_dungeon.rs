//! Integration test for the Stellar Dungeon example project.

use std::process::Command;

#[test]
fn test_stellar_dungeon_runs() {
    let output = Command::new("cargo")
        .args(&["run", "--", "run", "examples/stellar_dungeon/main.j"])
        .output()
        .expect("Failed to execute Stellar Dungeon");

    assert!(
        output.status.success(),
        "Stellar Dungeon should exit successfully. stderr: {}",
        String::from_utf8_lossy(&output.stderr)
    );

    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(
        stdout.contains("STELLAR DUNGEON"),
        "Output should contain title. Got: {}",
        stdout
    );
    assert!(
        stdout.contains("#########"),
        "Output should contain dungeon map"
    );
    assert!(
        stdout.contains("Gold: 100"),
        "Output should show final gold (100)"
    );
    assert!(
        stdout.contains("Thanks for playing"),
        "Output should contain sign-off"
    );
}
