URI
===

[![Swift][swift-badge]][swift-url]
[![Platform][platform-badge]][platform-url]
[![License][mit-badge]][mit-url]
[![Slack][slack-badge]][slack-url]

**URI** ([RFC 3986](https://tools.ietf.org/html/rfc3986)) for **Swift 3.0**.

## Usage

```swift
let uri = URI(string: "abc://username:password@example.com:123/path/data?key=value#fragid1")

uri.scheme // "abc"
uri.userInfo?.username // "username"
uri.userInfo?.password // "password"
uri.host // "example.com"
uri.port // 123
uri.path // "/path/data"
uri.query["key"] // "value"
uri.fragment // "fragid1"

let uri = URI(path: "/api/v1/tasks", query: ["done": "true"])

uri.path // "/api/v1/tasks"
uri.query["done"] // "true"
```

## Package

```swift
import PackageDescription

let package = Package(
	dependencies: [
		.Package(url: "https://github.com/Zewo/URI.git", majorVersion: 0, minor: 4)
	]
)

```

## Community

[![Slack](http://s13.postimg.org/ybwy92ktf/Slack.png)](http://slack.zewo.io)

Join us on [Slack](http://slack.zewo.io).

License
-------

**URI** is released under the MIT license. See LICENSE for details.

[swift-badge]: https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat
[swift-url]: https://swift.org
[platform-badge]: https://img.shields.io/badge/Platform-Mac%20%26%20Linux-lightgray.svg?style=flat
[platform-url]: https://swift.org
[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
[slack-image]: http://s13.postimg.org/ybwy92ktf/Slack.png
[slack-badge]: https://zewo-slackin.herokuapp.com/badge.svg
[slack-url]: http://slack.zewo.io
