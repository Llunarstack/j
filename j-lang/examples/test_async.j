// Test async/await system

out("Testing async/await system...")

// Define an async function
async fn | fetch_data(str | url) > {
    out("Fetching data from: " + url)
    return "Data from " + url
}

// Define another async function
async fn | process_data(str | data) > {
    out("Processing: " + data)
    return "Processed: " + data
}

// Call async functions with await
// Note: Currently executes synchronously since we don't have a full async runtime
result1 -> await fetch_data("https://api.example.com")
out("Result 1: " + result1)

result2 -> await process_data(result1)
out("Result 2: " + result2)

out("Async/await system test complete!")
