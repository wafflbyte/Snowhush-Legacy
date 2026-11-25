// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Snowhush",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", exact: "2.10.0"),
    ],
    targets: [
        // The libproc functions live in libSystem but their header is not part
        // of Darwin's umbrella module, so expose it to Swift as a small module.
        .systemLibrary(name: "CLibproc", path: "Sources/CLibproc"),
        .executableTarget(
            name: "Snowhush",
            dependencies: [
                "CLibproc",
                .product(name: "Sparkle", package: "Sparkle"),
            ],
            path: "Sources/Snowhush",
            // The per-frame loops reach class properties millions of times a second; Swift's runtime exclusivity
            // checks around each access cost as much as the physics itself.
            swiftSettings: [.unsafeFlags(["-enforce-exclusivity=unchecked"], .when(configuration: .release))],
            linkerSettings: [.unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks"])]
        ),
    ]
)
