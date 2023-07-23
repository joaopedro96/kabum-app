import ProjectDescription

// MARK: - SETTINGS

let targetConfigurations: [Configuration] = [
    .debug(name: .debug, xcconfig: Path("config/KabumTargetDebug.xcconfig")),
    .release(name: .release, xcconfig: Path("config/KabumTargetRelease.xcconfig"))]

let projectConfigurations: [Configuration] = [
    .debug(name: .debug, xcconfig: Path("config/KabumProjectDebug.xcconfig")),
    .release(name: .release, xcconfig: Path("config/KabumProjectRelease.xcconfig"))]

let targetSettings: Settings = .settings(
    configurations: targetConfigurations,
    defaultSettings: .none)

let projectSettings: Settings = .settings(
    configurations: projectConfigurations,
    defaultSettings: .none)

// MARK: - EXTERNAL PACKAGES

//let alamofirePackage = Package.remote(
//    url: "https://github.com/Alamofire/Alamofire.git",
//    requirement: .upToNextMajor(from: Version(5, 6, 4)))
//
//let kingfisherPackage = Package.remote(
//    url: "https://github.com/onevcat/Kingfisher.git",
//    requirement: .upToNextMajor(from: Version(5, 6, 4)))
//
//let rxSwiftPackage = Package.remote(
//    url: "https://github.com/ReactiveX/RxSwift.git",
//    requirement: .exact(Version(6, 6, 0)))
//
////let wormholePackage = Package.remote(url: "https://github.com/Alamofire/Alamofire.git",
////                                      requirement: .upToNextMajor(from: Version(5, 6, 4)))
//
//let floatingPanelPackage = Package.remote(
//    url: "https://github.com/scenee/FloatingPanel.git",
//    requirement: .upToNextMajor(from: Version(2, 6, 3)))
//
//let externalPackages: [Package] = [
//    alamofirePackage,
//    kingfisherPackage,
//    rxSwiftPackage,
//    floatingPanelPackage
//]

// MARK: - LOCAL PACKAGES

//let corePackage: Package = .package(path: "Core")

let externalPackage: [Package] = [
    .package(path: "ExternalPackages")
]

let localPackages: [Package] = [
    .package(path: "Core"),
    .package(path: "Network")
]

let packages: [Package] = localPackages + externalPackage

// MARK: - PACKAGE DEPENDENCIES

//let externalPackagesDependencies: [TargetDependency] = [
//    .package(product: "Alamofire"),
//    .package(product: "Kingfisher"),
//    .package(product: "RxSwift"),
//    .package(product: "FloatingPanel")
//]

let localPackagesDependencies: [TargetDependency] = [
    .package(product: "Core")
]

//let dweqdwq: SwiftPackageManagerDependencies = SwiftPackageManagerDependencies()

let packagesDependencies = localPackagesDependencies

// MARK: - TARGET

let kabumTarget = Target(
  name: "Kabum",
  platform: .iOS,
  product: .app,
  bundleId: "1.0.0",
  infoPlist: "Kabum/Sources/Core/Info.plist",
  sources: ["Kabum/Sources/**"],
  resources: ["Kabum/Resources/**"],
  dependencies: packagesDependencies,
  settings: targetSettings)

//let coreTarget = Target(
//    name: "Core",
//    platform: .iOS,
//    product: .staticLibrary,
//    bundleId: "1.0.1",
//    sources: ["Core"],
//    dependencies: externalPackagesDependencies)

// MARK: - PROJECT

let project = Project(
    name: "Kabum",
    organizationName: "joaoribeiro.co.team",
    packages: packages,
    settings: projectSettings,
    targets: [kabumTarget]
)
