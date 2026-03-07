// swift-tools-version: 6.2
import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "ElementaryViews",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "ElementaryViews", targets: ["ElementaryViews"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary-ui.git", from: "0.1.3"),
        .package(url: "https://github.com/swiftlang/swift-syntax", from: "602.0.0"),
    ],
    targets: [
        .target(
            name: "ElementaryViews",
            dependencies: [
                .product(name: "ElementaryUI", package: "elementary-ui"),
                "ViewMacros",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
        .macro(
            name: "ViewMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
    ]
)
