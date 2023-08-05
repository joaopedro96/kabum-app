// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(name: "ExternalPackages", path: "../../ExternalPackages"),
        .package(name: "Network", path: "../../Network"),
        .package(name: "Onboarding", path: "../../Onboarding"),
        .package(name: "Favorites", path: "../../Favorites")
    ],
    targets: [
        .target(name: "Core",
                dependencies: [
                    .byName(name: "ExternalPackages"),
                    .byName(name: "Network"),
                    .byName(name: "Onboarding"),
                    .byName(name: "Favorites")
                ],
                path: "Sources")
    ]
)
