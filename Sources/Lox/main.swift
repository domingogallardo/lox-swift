if CommandLine.arguments.count > 2 {
    print("Usage: jlox [script]")
} else {
    if (CommandLine.arguments.count == 2) {
        do {
            try runFile(path: CommandLine.arguments[1])
        } catch {
            print("Unexpected error: \(error)")
        }
    } else {
        runPrompt()
    }
}