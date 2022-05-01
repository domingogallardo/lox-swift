import Foundation

var hadError = false

func runFile(path: String) throws {
    let url = URL(fileURLWithPath: path)
    try run(source: String(contentsOf: url, encoding: .utf8))
    if (hadError) {
        exit(65)
    } 
}

func runPrompt() {
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

func run(source: String) {
    let tokens = source.components(separatedBy: .whitespacesAndNewlines)
    for token in tokens {
        print(token)
    }
}

func error(line: Int, message: String) {
    report(line: line, position: "", message: message)
}

func report(line: Int, position: String, message: String) {
    print("[line \(line)] Error \(position): \(message)")
    hadError = true
}