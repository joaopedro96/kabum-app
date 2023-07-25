// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Favorites",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Favorites",
            targets: ["Favorites"]),
    ],
    dependencies: [
        .package(name: "ExternalPackages", path: "../ExternalPackages"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Network", path: "../Network")
    ],
    targets: [
        .target(name: "Favorites",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "DesignSystem"),
                    .byName(name: "Network")
                ],
                path: "Sources")
    ]
)
