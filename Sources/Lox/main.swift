do {
    if CommandLine.arguments.count > 2 {
        print("Usage: jlox [script]")
    } else {
        if (CommandLine.arguments.count == 2) {
            try runFile(path: CommandLine.arguments[1])        
        } else {
            runPrompt()
        }
    }
} catch {
    print("Unexpected error: \(error)")
}
