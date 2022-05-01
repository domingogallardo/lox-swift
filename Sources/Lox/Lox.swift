import Foundation

func runFile(path: String) throws {
    let url = URL(fileURLWithPath: path)
    try run(source: String(contentsOf: url, encoding: .utf8))
}

func runPrompt() {
    while (true) {
        print("> ", terminator: "") 
        if let line = readLine() {
            run(source: line)
        } else {
            break
        }
    }
}

func run(source: String) {
    let tokens = source.components(separatedBy: .whitespacesAndNewlines)
    for token in tokens {
        print(token)
    }
}