import XCTest
@testable import URI

class URITests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension URITests {
    static var allTests : [(String, URITests -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
