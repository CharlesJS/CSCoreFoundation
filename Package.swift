// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CSCoreFoundation",
    products: [
        .library(
            name: "CSCoreFoundation",
            targets: ["CSCoreFoundation"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CSCoreFoundation",
            dependencies: []),
    ]
)
