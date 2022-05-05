struct Scanner {
    var source: String
    var tokens: [Token] = []
    var start = 0
    var current = 0
    var line = 1
    var isAtEnd: Bool {
        return current >= source.count
    }

    init(source: String) {
        self.source = source
    }

    mutating func scanTokens() -> [Token] {
        while (!isAtEnd) {
            start = current
            scanToken()
        }
        tokens.append(Token(type: .eof, lexeme: "", literal: nil, line: line))
        return tokens
    }

    mutating func scanToken() {
        let c = advance()
        switch c {
            case "(": addToken(type: .leftParen)
            case ")": addToken(type: .rightParen)
            case "{": addToken(type: .leftBrace)
            case "}": addToken(type: .rightBrace)
            case ",": addToken(type: .comma)
            case ".": addToken(type: .dot)
            case "-": addToken(type: .minus)
            case "+": addToken(type: .plus)
            case ";": addToken(type: .semicolon)
            case "*": addToken(type: .star)
            default: break
        }
    }

    mutating func advance() -> Character {
        let index = source.index(source.startIndex, offsetBy: current)
        current += 1
        return source[index]
    }

    mutating func addToken(type: TokenType) {
        addToken(type: type, literal: nil)
    }

    mutating func addToken(type: TokenType, literal: Any?) {
        let start = source.index(source.startIndex, offsetBy: start)
        let end = source.index(source.startIndex, offsetBy: current)
        let text = String(source[start..<end])
        tokens.append(Token(type: type, lexeme: text, literal: literal, line: line))
    }
}