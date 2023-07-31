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
        .package(name: "ExternalPackages", path: "../../ExternalPackages"),
        .package(name: "Network", path: "../../Network"),
        .package(name: "Departments", path: "../../Departments")
    ],
    targets: [
        .target(name: "Engine",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "Network"),
                    .byName(name: "Departments")
                ],
                path: "Sources")
    ]
)
