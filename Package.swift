import PackageDescription

let package = Package(
    name: "URI",
    dependencies: [
        .Package(url: "https://github.com/Zewo/CURIParser.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/Zewo/String.git", majorVersion: 0, minor: 2)
    ]
)
