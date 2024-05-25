// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainModule",
    platforms: [
        .iOS(.v13), // 适用于 iOS 13 及以上版本
        .macOS(.v10_15), // 适用于 macOS 10.15 及以上版本
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KeychainModule",
            targets: ["KeychainModule"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KeychainModule"),
        .testTarget(
            name: "KeychainModuleTests",
            dependencies: ["KeychainModule"]),
    ]
)
