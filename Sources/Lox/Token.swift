struct Token {
    let type: TokenType
    let lexeme: String
    let literal: Any?
    let line: Int

    init(type: TokenType, lexeme: String, literal: Any?, line: Int) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }
}

extension Token: CustomStringConvertible {
    var description: String {
        if let literal = literal {
            return("\(type) \(lexeme) \(literal)")
        } else {
            return("\(type) \(lexeme)")
        }
    }
}