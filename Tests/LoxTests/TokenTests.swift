@testable import Lox
import XCTest

final class TokenTests: XCTestCase {

    func testTokenWithoutLiteralsStringDescribing() {
        XCTAssertEqual(String(describing: Token(type: .plus, lexeme: "+", literal: nil, line: 0)), "plus +")
        XCTAssertEqual(String(describing: Token(type: .leftParen, lexeme: "(", literal: nil, line: 0)), "leftParen (")
    }

    func testTokenWithLiteralsStringDescribing() {
        XCTAssertEqual(String(describing: Token(type: .number, lexeme: "100", literal: 100, line: 0)), "number 100 100")
        XCTAssertEqual(String(describing: Token(type: .string, lexeme: "Hola", literal: "Hola", line: 0)), "string Hola Hola")
    }
    
    static var allTests = [
        ("testTokenWithoutLiteralsStringDescribing", testTokenWithoutLiteralsStringDescribing),
        ("testTokenWithLiteralsStringDescribing",testTokenWithLiteralsStringDescribing)
    ]
}
