// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AdventOfCode2024",
  platforms: [.macOS(.v15)],
  products: [
    .executable(name: "Day1", targets: ["Day1"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0")
  ],
  targets: [.target(name: "Utils")] +
  day(1) +
  day(2) +
  day(3)
)

func day(
  _ day: Int,
  dependencies: [Target.Dependency] = [],
  hasResources: Bool = true
) -> [Target] {
  [
    .executableTarget(
      name: "Day\(day)",
      dependencies: [
        .product(name: "Parsing", package: "swift-parsing"),
        "Utils"
      ] + dependencies,
      resources: hasResources ? [.copy("input.txt")] : []
    ),
    .testTarget(
      name: "Day\(day)Tests",
      dependencies: [
        .target(name: "Day\(day)")
      ]
    )
  ]
}
