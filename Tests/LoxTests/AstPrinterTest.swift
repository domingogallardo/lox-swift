@testable import Lox
import XCTest

final class AstPrinterTests: XCTestCase {

    func testPrintBinaryExpression() {
        let expression = 
        Expr.Binary(
            left: Expr.Unary(
                    op: Token(type: TokenType.minus, lexeme: "-", line: 1), 
                    right: Expr.Literal(value: 123)), 
            op: Token(type: TokenType.star, lexeme: "*", line: 1), 
            right: Expr.Grouping(expression: Expr.Literal(value: 45.67)))
        XCTAssertEqual(AstPrinter().print(expr: expression), "(* (- 123) (group 45.67))")
    }

    func testPrintUnaryExpression() {
        let expression = 
        Expr.Unary(
            op: Token(type: TokenType.bang, lexeme: "!", line: 1), 
            right: Expr.Binary(
                    left: Expr.Literal(value: "1"),
                    op: Token(type: TokenType.or, lexeme: "or", line: 1), 
                    right: Expr.Literal(value: "0")))
        XCTAssertEqual(AstPrinter().print(expr: expression), "(! (or 1 0))")
    }

    static var allTests = [
        ("testPrintBinaryExpression", testPrintBinaryExpression),
        ("testPrintUnaryExpression", testPrintUnaryExpression)
    ]
}
