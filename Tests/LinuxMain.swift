#if os(Linux)

import XCTest
@testable import URITests

XCTMain([
    testCase(URITests.allTests)
])

#endif
