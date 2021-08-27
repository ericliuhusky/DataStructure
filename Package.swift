// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataStructure",
    products: [
//        .library(
//            name: "DataStructure",
//            targets: ["DataStructure"]),
        .executable(name: "DataStructure", targets: ["DataStructure"])
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "DataStructure",
            dependencies: []),
        .testTarget(
            name: "DataStructureTests",
            dependencies: ["DataStructure"]),
    ]
)
