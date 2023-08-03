// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Engine",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Engine",
            targets: ["Engine"]),
    ],
    dependencies: [
        .package(name: "ExternalPackages", path: "../ExternalPackages"),
        .package(name: "Network", path: "../Network"),
        .package(name: "Home", path: "../Home"),
        .package(name: "Departments", path: "../Departments"),
        .package(name: "Favorites", path: "../Favorites"),
        .package(name: "Account", path: "../Account")
    ],
    targets: [
        .target(name: "Engine",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "Network"),
                    .byName(name: "Home"),
                    .byName(name: "Departments"),
                    .byName(name: "Favorites"),
                    .byName(name: "Account")
                ],
                path: "Sources")
    ]
)
