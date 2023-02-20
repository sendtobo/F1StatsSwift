// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "F1Stats",
    platforms: [.macOS(.v13), .iOS(.v16)],
    products: [
        .library(
            name: "F1Stats",
            targets: ["F1Stats"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "11.2.1")),
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.2.2"),
    ],
    targets: [
        .target(
            name: "F1Stats",
            dependencies: [],
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]),
        .testTarget(
            name: "F1StatsTests",
            dependencies: [
                "F1Stats", "Quick", "Nimble"
            ]),
    ]
)
