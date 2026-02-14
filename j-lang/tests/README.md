# J Language Tests

Test suite for the J programming language.

## Structure

- **unit/** - Unit tests for individual components
- **integration/** - Integration tests for full features
- **fixtures/** - Test J programs used by integration tests

## Running Tests

```bash
# Run all tests
cargo test

# Run specific test
cargo test test_name

# Run with output
cargo test -- --nocapture
```

## Writing Tests

### Integration Tests
Place in `integration/` directory. Use fixtures from `fixtures/` for test programs.

### Fixtures
Test J programs in `fixtures/` should be:
- Self-contained
- Well-commented
- Test one feature at a time
