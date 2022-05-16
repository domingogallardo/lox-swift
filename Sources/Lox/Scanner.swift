class Scanner {
    var source: String
    var tokens: [Token] = []
    var start = 0
    var current = 0
    var line = 1
    var isAtEnd: Bool {
        return current >= source.count
    }
    let keywords : [String : TokenType] = [
        "and": .and,
        "class": .kclass,
        "else": .kelse,
        "false": .kfalse,
        "for": .kfor,
        "fun": .fun,
        "if": .kif,
        "nil": .knil,
        "or": .or,
        "print": .print,
        "return": .kreturn,
        "super": .ksuper,
        "this": .this,
        "true": .ktrue,
        "var": .kvar,
        "while": .kwhile]

    init(source: String) {
        self.source = source
    }

    func scanTokens() -> [Token] {
        while (!isAtEnd) {
            // We are at the beginning of the next lexeme.
            start = current
            scanToken()
        }
        tokens.append(Token(type: .eof, lexeme: "", literal: nil, line: line))
        return tokens
    }

    func scanToken() {
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
            case "!": addToken(type: match("=") ? .bangEqual : .bang)
            case "=": addToken(type: match("=") ? .equalEqual : .equal)
            case "<": addToken(type: match("=") ? .lessEqual : .less)
            case ">": addToken(type: match("=") ? .greaterEqual : .greater)
            case "/": 
                if (match("/")) {
                    // A comment goes until the end of the line.
                    while (peek() != "\n" && !isAtEnd) {
                        let _ = advance() // We use 'let' to prevent 'result is unused' warning.
                    } 
                } else {
                    addToken(type: .slash)
                }
            case " ", "\r", "\t": break // Ignore whitespace.
            case "\n": line += 1
            case "\"": string()
            default:
                if (isDigit(c)) {
                    number()
                } else if (isAlpha(c)) {
                    identifier()
                } else {
                    Lox.error(line: line, message: "Unexpected character.")
                }
        }
    }

    func identifier() {
        while (isAlphaNumeric(peek())) {
            let _ = advance()
        }
        let text = source[start..<current]
        if let type = keywords[text] {
            addToken(type: type)
        } else {
            addToken(type: .identifier)
        } 
    }

    func number() {
        while (isDigit(peek())) {
            let _ = advance()
        }

        // Loook for a fractional part.
        if (peek() == "." && isDigit(peekNext())) {
            // Consume the "."
            let _ = advance()
            while (isDigit(peek())) {
                let _ = advance()
            }
        }
        addToken(type: .number, literal: Double(source[start..<current]))
    }

    func string() {
        while (peek() != "\"" && !isAtEnd)  {
            if (peek() == "\n") {
                line += 1
            }
            let _ = advance()
        }
        if (isAtEnd) {
            Lox.error(line: line, message: "Unterminated string.")
            return
        }
        let _ = advance() // The closing ".

        // Trim the surrounding quotes.
        let value = String(source[start + 1..<current - 1])
        addToken(type: .string, literal: value)
    }

    func match(_ expected: Character) -> Bool {
        if (isAtEnd) {
            return false
        }
        if (source[current] != expected) {
            return false
        }
        current += 1
        return true
    }

    func peek() -> Character {
        if (isAtEnd) {
            return "\0"
        }
        return source[current]
    }

    func peekNext() -> Character {
        if (current + 1 >= source.count) {
            return "\0"
        }
        return source[current+1]
    }

    func advance() -> Character {
        current += 1
        return source[current-1]
    }

    func addToken(type: TokenType) {
        addToken(type: type, literal: nil)
    }

    func addToken(type: TokenType, literal: Any?) {
        let text = source[start..<current]
        tokens.append(Token(type: type, lexeme: text, literal: literal, line: line))
    }
}

func isDigit(_ c: Character) -> Bool {
    return c >= "0" && c <= "9"
}

func isAlpha(_ c: Character) -> Bool {
    return (c >= "a" && c <= "z") ||
           (c >= "A" && c <= "Z") ||
           c == "_"
}

func isAlphaNumeric(_ c: Character) -> Bool {
    return isAlpha(c) || isDigit(c)
}