@testable import Lox
import XCTest

final class ScannerTests: XCTestCase {

    func testAdvance() {
        let scanner = Scanner(source: "+ - * 2")
         XCTAssertEqual(scanner.advance(), "+")
         XCTAssertEqual(scanner.advance(), " ")
         XCTAssertEqual(scanner.advance(), "-")
         XCTAssertEqual(scanner.advance(), " ")
         XCTAssertEqual(scanner.advance(), "*")
         XCTAssertEqual(scanner.advance(), " ")
         XCTAssertEqual(scanner.advance(), "2")
    }

    static var allTests = [
        ("testAdvance", testAdvance),
    ]
}
