import XCTest
@testable import URI

class URITests: XCTestCase {
    func testQuery() {

        do {
            let uri = try URI("http://www.example.com:80/dir/subdir?param=1&param=2;param%20=%20#fragment")

            XCTAssertEqual(uri.scheme, "http")
            XCTAssertEqual(uri.host, "www.example.com")
            XCTAssertEqual(uri.port, 80)
            XCTAssertEqual(uri.path, "/dir/subdir")
            XCTAssertEqual(uri.query, "param=1&param=2;param%20=%20")
            XCTAssertEqual(uri.fragment, "fragment")

        } catch {
            XCTFail(String(error))
        }
    }
}

extension URITests {
    static var allTests: [(String, URITests -> () throws -> Void)] {
        return [
           ("testQuery", testQuery),
        ]
    }
}
