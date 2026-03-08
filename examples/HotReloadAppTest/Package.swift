// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "HotReloadAppTest",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary-ui.git", from: "0.1.3"),
        .package(name: "ElementaryViews", path: "../.."),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "ElementaryUI", package: "elementary-ui"),
                .product(name: "ElementaryViews", package: "ElementaryViews"),
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
