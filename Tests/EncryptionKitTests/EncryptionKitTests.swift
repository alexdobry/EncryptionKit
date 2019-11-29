import XCTest
@testable import EncryptionKit

final class EncryptionKitTests: XCTestCase {
    
    private let encryption = AESEncryption()

    func testEncryption() {
        let key = encryption.randomKey()
        let values = ["test", "+test123", "hello world", "foo bar 123", ""]
        
        values.forEach { value in
            assert(value, decrypt(key, encrypt(key, value)))
        }
    }
    
    private func assert(_ expected: String, _ result: Result<String, Error>) {
        switch result {
        case .success(let actual):
            XCTAssertEqual(expected, actual)
        case .failure(let e):
            XCTFail(e.localizedDescription)
        }
    }
    
    private func encrypt(_ key: String, _ value: String) -> Result<String, Error> {
        return encryption.encrypt(string: value, key: key)
    }
    
    private func decrypt(_ key: String, _ value: Result<String, Error>) -> Result<String, Error> {
        return value.flatMap { encryption.decrypt(string: $0, key: key) }
    }

    static var allTests = [
        ("testEncryption", testEncryption),
    ]
}
