# Swift/iOS Stack Patterns

## Detection Signals

- `Package.swift` → Swift Package
- `*.xcodeproj` → Xcode Project
- `*.xcworkspace` → Xcode Workspace

## Test Commands

- **Primary**: `swift test --parallel`
- **Framework**: Swift Testing (`@Test`, `@Suite`, `#expect`) preferred over XCTest
- **Lint**: `swiftlint` (if installed)
- **Build**: `xcodebuild build`

## Capabilities

- **SwiftLint**: Check `command -v swiftlint`
- **XcodeBuildMCP**: Check `~/.claude/skills/xcodebuildmcp/SKILL.md`
- **Swift Testing**: Always available (Swift 5.9+)

## Key Patterns

- Use `guard let` for early returns over `if let`
- `[weak self]` in closures to prevent retain cycles
- `@MainActor` for UI-related code
- `async/await` over completion handlers
- Protocol-oriented design
- MVVM or MVVM-C architecture

## Test Patterns (Swift Testing)

```swift
import Testing

@Suite("Feature Tests")
struct FeatureTests {
    @Test("Description of test case")
    func testBehavior() {
        let sut = MyFeature()
        #expect(sut.result == expected)
    }

    @Test("Throws on invalid input")
    func testThrows() {
        #expect(throws: MyError.self) {
            try riskyOperation()
        }
    }
}
```
