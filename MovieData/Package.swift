// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieData",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "MovieData",
                 targets: ["MovieData"]),
    ],
    dependencies: [
        // InitMacro package to generate model initializers in compile time.
        .package(
            url: "https://github.com/LeonardoCardoso/InitMacro.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(name: "MovieData", dependencies: ["InitMacro"]),
        .testTarget(name: "MovieDataTests",
                    dependencies: ["MovieData"]),
    ]
)
