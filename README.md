URI
===

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://swift.org)
[![Platforms Linux](https://img.shields.io/badge/Platforms-Linux-lightgray.svg?style=flat)](https://swift.org/download/#linux)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://tldrlegal.com/license/mit-license)
[![Slack Status](http://slack.zewo.io/badge.svg)](http://slack.zewo.io)

**URI** ([RFC 3986](https://tools.ietf.org/html/rfc3986)) for **Swift 2.2**.

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

## Installation

- Install [`uri_parser`](https://github.com/Zewo/uri_parser)

### Homebrew
```bash
$ brew tap zewo/tap
$ brew install uri_parser
```

### Ubuntu/Debian
```bash
$ echo "deb [trusted=yes] http://apt.zewo.io/deb ./" | sudo tee --append /etc/apt/sources.list
$ sudo apt-get update
$ sudo apt-get install uri_parser
```

### Source
```bash
$ git clone https://github.com/Zewo/uri_parser.git && cd uri_parser
$ make
$ (sudo) make install
```

- Add `URI` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
	dependencies: [
		.Package(url: "https://github.com/Zewo/URI.git", majorVersion: 0, minor: 2)
	]
)

```

## Community

[![Slack](http://s13.postimg.org/ybwy92ktf/Slack.png)](http://slack.zewo.io)

Join us on [Slack](http://slack.zewo.io).

License
-------

**URI** is released under the MIT license. See LICENSE for details.
