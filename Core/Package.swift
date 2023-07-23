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
//        .package(name: "Alamofire", path: ".")
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.4")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.6.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.6.4")),
        .package(url: "https://github.com/scenee/FloatingPanel.git", .upToNextMajor(from: "2.6.3"))
    ],
    targets: [
        .target(name: "Core",
                dependencies: [
                    .byName(name: "Alamofire"),
                    .byName(name: "RxSwift"),
                    .byName(name: "Kingfisher"),
                    .byName(name: "FloatingPanel"),
                ],
                path: "Sources")
    ]
)
