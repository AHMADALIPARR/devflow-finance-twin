// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

import PackageDescription

let package = Package(
    name: "MetalTransformer",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "MetalTransformer",  targets: ["MetalTransformer"]),
        .executable(name: "swift-tiny-llm", targets: ["SwiftTinyLLM"]),
    ],
    targets: [
        .target(
            name: "MetalTransformer",
            path: "Sources/MetalTransformer",
            resources: [.copy("Transformer.metal")]
        ),
        .executableTarget(
            name: "SwiftTinyLLM",
            path: "Sources/SwiftTinyLLM"
        ),
        .testTarget(
            name: "MetalTransformerTests",
            dependencies: ["MetalTransformer"],
            path: "Tests"
        ),
    ]
)
