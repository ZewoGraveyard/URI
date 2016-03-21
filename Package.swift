import PackageDescription

let package = Package(
    name: "URI",
    dependencies: [
        .Package(url: "https://github.com/Zewo/String.git", majorVersion: 0, minor: 4),
        .Package(url: "https://github.com/Zewo/CURIParser.git", majorVersion: 0, minor: 4),
        .Package(url: "https://github.com/swiftx/c7.git", majorVersion: 0, minor: 1)
    ]
)
