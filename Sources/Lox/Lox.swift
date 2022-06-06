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
        let scanner = Scanner(source: source)
        let tokens = scanner.scanTokens()

        let parser = Parser(tokens: tokens)
        guard let expression = try? parser.parse() else {
            // más adelante tendremos que sincronizar para seguir parseando
            return
        }
        if (hadError) {
            return
        }
        print(AstPrinter().print(expr: expression))
    }

    static func error(line: Int, message: String) {
        report(line: line, position: "", message: message)
    }

    static func report(line: Int, position: String, message: String) {
        print("[line \(line)] Error\(position): \(message)")
        hadError = true
    }

    static func error(token: Token, message: String) {
        if (token.type == .eof) {
            report(line: token.line, position: " at end", message: message)
        } else {
            report(line: token.line, position: " at '\(token.lexeme)'", message: message)
        }
    }
}

/*
@main
struct Prueba {
    static func main() {
        let expression = 
        Expr.Binary(
            left: Expr.Unary(
                    op: Token(type: TokenType.minus, lexeme: "-", literal: nil, line: 1), 
                    right: Expr.Literal(value: 123)), 
            op: Token(type: TokenType.star, lexeme: "*", literal: nil, line: 1), 
            right: Expr.Grouping(expression: Expr.Literal(value: 45.67)))
        print(AstPrinter().print(expr: expression))
    }
}
*/