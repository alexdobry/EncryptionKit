import XCTest
@testable import EncryptionKit

final class EncryptionKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EncryptionKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
