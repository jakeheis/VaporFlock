import PackageDescription

let package = Package(
    name: "VaporFlock",
    dependencies: [
        .Package(url: "../Flock", majorVersion: 0, minor: 0)
    ]
)
