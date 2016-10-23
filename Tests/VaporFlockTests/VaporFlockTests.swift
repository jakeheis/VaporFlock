import XCTest
@testable import VaporFlock

class VaporFlockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(VaporFlock().text, "Hello, World!")
    }


    static var allTests : [(String, (VaporFlockTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
