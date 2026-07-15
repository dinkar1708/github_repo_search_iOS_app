# Integration Tests

## What This Folder Tests

**Purpose:** Test multiple components working together (API → Repository → ViewModel).

**Framework:** XCTest or Swift Testing

**Coverage Goal:** 70-80%

---

## Current Tests (0 tests)

**Status:** Not yet implemented

**Future Candidates:**
1. **Full Search Flow** - User input → Repository → API → Parse → Display
2. **Pagination Flow** - Scroll → Load more → API → Append results
3. **Error Flow** - API error → Repository → ViewModel → UI error state

---

## How to Run

### When Implemented:
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:IntegrationTests
```

---

## Example Integration Test

```swift
import XCTest
@testable import github_repo_search_iOS_app

@MainActor
class SearchFlowIntegrationTests: XCTestCase {
    func testCompleteSearchFlow() async throws {
        // Arrange
        let viewModel = HomeViewModel()

        // Act
        viewModel.searchText = "swift"

        // Wait for API call (3 second throttle + network)
        try await Task.sleep(nanoseconds: 5_000_000_000)

        // Assert
        XCTAssertGreaterThan(viewModel.searchItems.count, 0)
        XCTAssertEqual(viewModel.messageState, .loaded)
    }
}
```

---

## What Makes a Good Integration Test

✅ **Tests real interactions** - Multiple components working together
✅ **Uses real implementations** - Not mocks (except external APIs)
✅ **Catches wiring bugs** - Things that work alone but fail together
✅ **Slower than unit tests** - But faster than UI tests
✅ **Fewer in number** - Focus on critical paths
