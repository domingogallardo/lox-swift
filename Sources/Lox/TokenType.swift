enum TokenType {
    // Single-character tokens
    case leftParen, rightParen, leftBrace, rightBrace
    case comma, dot, minus, plus, semicolon, slash, star

    // One or two character tokens
    case bang, bangEqual, equal, equalEqual
    case greater, greaterEqual, less, lessEqual

    // Literals
    case identifier, string, number

    // Keywords
    case and, tclass, telse, tfalse, fun, tfor, tif, tnil, or
    case print, treturn, tsuper, this, ttrue, tvar, twhile
    case eof
}