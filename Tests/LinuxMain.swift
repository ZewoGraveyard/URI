#if os(Linux)

import XCTest
@testable import URITestSuite

XCTMain([
    testCase(URITests.allTests)
])

#endif
