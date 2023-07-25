// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: "ExternalPackages", path: "../ExternalPackages"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Network", path: "../Network")
    ],
    targets: [
        .target(name: "Home",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "DesignSystem"),
                    .byName(name: "Network")
                ],
                path: "Sources")
    ]
)
