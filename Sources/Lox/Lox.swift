import Foundation

@main
struct Lox {
    static var hadError = false

    static func main() {
        if CommandLine.arguments.count > 2 {
            print("Usage: jlox [script]")
        } else {
            if (CommandLine.arguments.count == 2) {
                do {
                    try runFile(path: CommandLine.arguments[1])
                } catch {
                print("Unexpected error: \(error)")
                exit(64)
            }
            } else {
                runPrompt()
            }
        }
    }

    static func runFile(path: String) throws {
        let url = URL(fileURLWithPath: path)
        try run(source: String(contentsOf: url, encoding: .utf8))
        if (hadError) {
            exit(65)
        } 
    }

    static func runPrompt() {
        while (true) {
            print("> ", terminator: "") 
            if let line = readLine() {
                run(source: line)
                hadError = false
            } else {
                break
            }
        }
    }

    static func run(source: String) {
        let tokens = source.components(separatedBy: .whitespacesAndNewlines)
        for token in tokens {
            print(token)
        }
    }

    static func error(line: Int, message: String) {
        report(line: line, position: "", message: message)
    }

    static func report(line: Int, position: String, message: String) {
        print("[line \(line)] Error \(position): \(message)")
        hadError = true
    }
}