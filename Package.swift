// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCPJiraLight",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/tomieq/swifter", .upToNextMajor(from: "3.1.1")),
        .package(url: "https://github.com/tomieq/Logger", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/tomieq/Env", .upToNextMajor(from: "1.0.8")),
        .package(url: "https://github.com/tomieq/WebResponse", branch: "master"),
        .package(url: "https://github.com/tomieq/MCPServer", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "MCPJiraLight",
            dependencies: [
                .product(name: "Swifter", package: "Swifter"),
                .product(name: "Logger", package: "Logger"),
                .product(name: "MCPServer", package: "MCPServer"),
                .product(name: "Env", package: "Env"),
                .product(name: "WebResponse", package: "WebResponse")
            ]
        ),
    ],
    swiftLanguageModes: [.v5]
)
