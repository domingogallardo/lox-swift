class Parser {

    enum Error: Swift.Error {
        case parseFailure
    }

    var tokens: [Token]
    var current = 0

    init(tokens: [Token]) {
        self.tokens = tokens
    }

    func parse() throws -> Expr {
        return try expression()
    }

    func expression() throws -> Expr {
        return try equality()
    }

    func equality() throws -> Expr {
        var expr = try comparison()

        while (match(.bangEqual, .equalEqual)) {
            let op = previous()
            let right = try comparison()
            expr = Expr.Binary(left: expr, op: op, right: right)
        }

        return expr
    }

    func comparison() throws -> Expr {
        var expr = try term()

        while (match(.greater, .greaterEqual, .less, .lessEqual)) {
            let op = previous()
            let right = try term()
            expr = Expr.Binary(left: expr, op: op, right: right)
        }

        return expr
    }

    func term() throws -> Expr {
        var expr = try factor()

        while (match(.minus, .plus)) {
            let op = previous()
            let right = try factor()
            expr = Expr.Binary(left: expr, op: op, right: right)
        }

        return expr
    }

    func factor() throws -> Expr {
        var expr = try unary()

        while (match(.slash, .star)) {
            let op = previous()
            let right = try unary()
            expr = Expr.Binary(left: expr, op: op, right: right)
        }

        return expr
    }

    func unary() throws -> Expr {
        if (match(.bang, .minus)) {
            let op = previous()
            let expr = try unary()
            return Expr.Unary(op: op, right: expr)
        }

        return try primary()
    }

    func primary() throws -> Expr {
        if (match(.kfalse)) {
            return Expr.Literal(value: false)
        }
        if (match(.ktrue)) {
            return Expr.Literal(value: true)
        }
        if (match(.knil)) {
            return Expr.Literal(value: nil)
        }
        if (match(.number, .string)) {
            return Expr.Literal(value: previous().literal)
        }
        if (match(.leftParen)) {
            let expr = try expression()
            let _ = try consume(type: .rightParen, message: "Expect ')' after expression.")
            return Expr.Grouping(expression: expr)
        }

        throw error(token: peek(), message: "Expect expression.")
    }

    func match(_ types: TokenType...) -> Bool {
        for type in types {
            if (check(type)) {
                let _ = advance()
                return true
            }
        }
        return false
    }

    func consume(type: TokenType, message: String) throws -> Token {
        if (check(type)) {
            return advance()
        }
        
        throw error(token: peek(), message: message)
    }

    func check(_ type: TokenType) -> Bool {
        if (isAtEnd()) {
            return false
        }
        return peek().type == type
    }

    func advance() -> Token {
        if (!isAtEnd()) {
            current += 1;
        }
        return previous()
    }

    func isAtEnd() -> Bool {
        return peek().type == .eof
    }

    func peek() -> Token {
        return tokens[current]
    }

    func previous() -> Token {
        return tokens[current - 1]
    }

    func error(token: Token, message: String) -> Parser.Error {
        Lox.error(token: token, message: message)
        return Parser.Error.parseFailure
    }

    func sychronizye() {
        let _ = advance()
        while !isAtEnd() {
            if (previous().type == .semicolon) {
                return
            }
            switch (peek().type) {
                case .kclass, .kfor, .fun, .kif, .print, .kreturn, .kvar, .kwhile:
                    return
                default:
                    break
            }
            let _ = advance()
        }
    }
}
