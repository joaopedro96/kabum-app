// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Onboarding",
            targets: ["Onboarding"]),
    ],
    dependencies: [
        .package(name: "Network", path: "../Network"),
    ],
    targets: [
        .target(name: "Onboarding",
                dependencies: [
                    .byName(name: "Network"),
                ],
                path: "Sources")
    ]
)
