import ProjectDescription

// MARK: - SETTINGS

let targetConfigurations: [Configuration] = [
    .debug(name: .debug, xcconfig: Path("../config/KabumTargetDebug.xcconfig")),
    .release(name: .release, xcconfig: Path("../config/KabumTargetRelease.xcconfig"))]

let projectConfigurations: [Configuration] = [
    .debug(name: .debug, xcconfig: Path("../config/KabumProjectDebug.xcconfig")),
    .release(name: .release, xcconfig: Path("../config/KabumProjectRelease.xcconfig"))]

let targetSettings: Settings = .settings(
    configurations: targetConfigurations,
    defaultSettings: .none)

let projectSettings: Settings = .settings(
    configurations: projectConfigurations,
    defaultSettings: .none)

// MARK: - PACKAGES

let externalPackage: [Package] = [
    .package(path: "../ExternalPackages")
]

let localPackages: [Package] = [
    .package(path: "../Onboarding"),
    .package(path: "Core"),
    .package(path: "../Network"),
    .package(path: "../DesignSystem"),
    .package(path: ".")
]

let packages: [Package] = localPackages + externalPackage

// MARK: - PACKAGE DEPENDENCIES

let coreAppDependency: [TargetDependency] = [
    .package(product: "Onboarding")
]

// MARK: - TARGET

let appTarget = Target(
  name: "Kabum",
  platform: .iOS,
  product: .app,
  bundleId: "1.0.9",
  infoPlist: "../Kabum/Sources/Core/Info.plist",
  sources: ["../Kabum/Sources/**"],
  resources: ["../Kabum/Resources/**"],
  dependencies: coreAppDependency,
  settings: targetSettings)

// MARK: - PROJECT

let project = Project(
    name: "Account",
    organizationName: "joaoribeiro.co.team.account",
    packages: packages,
    settings: projectSettings,
    targets: [appTarget]
)
