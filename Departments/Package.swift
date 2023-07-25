// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Departments",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Departments",
            targets: ["Departments"]),
    ],
    dependencies: [
        .package(name: "ExternalPackages", path: "../ExternalPackages"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Network", path: "../Network")
    ],
    targets: [
        .target(name: "Departments",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "DesignSystem"),
                    .byName(name: "Network")
                ],
                path: "Sources")
    ]
)
