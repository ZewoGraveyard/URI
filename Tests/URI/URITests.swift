import XCTest
@testable import URI

class URITests: XCTestCase {
    func testQuery() {
        let original = URI(
            path: "/",
            query: [
                       "foo": ["bar barão \\!@#$&%$#", "baz \\!@#$&@#$! anêmona"],
                       "fuu": [""],
                       "fou": [nil]
            ]
        )

        guard let encoded = try? original.percentEncoded() else {
            XCTFail()
            return
        }

        XCTAssertEqual(encoded, "/?foo=bar%20bar%C3%A3o%20%5C!@%23$%26%25$%23&foo=baz%20%5C!@%23$%26@%23$!%20an%C3%AAmona&fou&fuu=")

        guard let decoded = try? URI(encoded) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decoded, original)
    }
}

extension URITests {
    static var allTests: [(String, URITests -> () throws -> Void)] {
        return [
           ("testQuery", testQuery),
        ]
    }
}
