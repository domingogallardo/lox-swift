enum TokenType {
    // Single-character tokens.
    case leftParen, rightParen, leftBrace, rightBrace
    case comma, dot, minus, plus, semicolon, slash, star

    // One or two character tokens.
    case bang, bangEqual, equal, equalEqual
    case greater, greaterEqual, less, lessEqual

    // Literals.
    case identifier, string, number

    // Keywords.
    case and, kclass, kelse, kfalse, fun, kfor, kif, knil, or
    case print, kreturn, ksuper, this, ktrue, kvar, kwhile
    case eof
}