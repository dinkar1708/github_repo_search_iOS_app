# UI Tests

## What This Folder Tests

**Purpose:** Test real user interactions on screen - taps, swipes, typing.

**Framework:** XCTest (XCUITest)

**Coverage Goal:** Critical user journeys only

---

## Current Tests (3 tests)

**File:** `HomeView_appUITests.swift`

| Test Name | What It Tests | Duration | Status |
|-----------|---------------|----------|--------|
| `testHomeHeadView` | Navigation bar, search field, header text appear | ~6s | ✅ Pass |
| `testHomeViewBodySearchField` | Search field accepts input and can be cleared | ~10s | ✅ Pass |
| `testHomeViewBodySearchResult` | Search results display or show appropriate message | ~13s | ✅ Pass |

**Code Coverage Impact:**
- HomeView.swift: 87.63%
- AppSearchBar.swift: 100%
- User interaction flows verified

---

## How to Run

### Run All UI Tests
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appUITests/HomeView_appUITests
```

### Run Specific Test
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appUITests/HomeView_appUITests/testHomeHeadView
```

### In Xcode
1. Open Test Navigator (⌘6)
2. Expand `github_repo_search_iOS_appUITests`
3. Click ▶ next to test
4. Watch simulator run through user flow

---

## Latest Results

**Run Date:** 2026-07-15

**Result:** ✅ All tests passing (3/3)

**Total Execution Time:** ~29 seconds

**Test Breakdown:**
```
Test Suite 'HomeView_appUITests' passed at 22:36:54
Executed 3 tests, with 0 failures in 28.896 seconds

✅ testHomeHeadView - 6.156s
✅ testHomeViewBodySearchField - 10.522s
✅ testHomeViewBodySearchResult - 13.978s
```

---

## Test Details

### testHomeHeadView
**What:** Verifies home screen loads correctly after splash
**Steps:**
1. Launch app
2. Wait for splash screen (3 seconds)
3. Check navigation bar exists ("GitHub Search")
4. Check search field exists
5. Check header text exists ("Repository Search")

### testHomeViewBodySearchField
**What:** Tests search field interaction
**Steps:**
1. Launch app
2. Tap search field
3. Type "swift"
4. Verify text was entered
5. Attempt to clear field

### testHomeViewBodySearchResult
**What:** Tests search results appear
**Steps:**
1. Launch app
2. Tap search field
3. Type "swift"
4. Wait 6 seconds (3s throttle + network)
5. Verify results or appropriate message shows

---

## Why UI Tests Are Slow

UI tests are 10-20x slower than unit tests because they:
- Launch the full app
- Run on simulator/device
- Wait for animations
- Handle network requests
- Interact with real UI elements

**Best Practice:** Keep UI tests few and focused on critical user journeys.

---

## Writing New UI Tests

```swift
import XCTest

final class MyUITests: XCTestCase {
    func testUserFlow() {
        let app = XCUIApplication()
        app.launch()

        // Tap button
        app.buttons["Button ID"].tap()

        // Type text
        app.textFields["Search"].tap()
        app.textFields["Search"].typeText("query")

        // Verify element exists
        XCTAssertTrue(app.staticTexts["Result"].exists)

        // Wait for element
        let element = app.staticTexts["Loading"]
        XCTAssertTrue(element.waitForExistence(timeout: 5))
    }
}
```

---

## Best Practices

✅ **Test critical paths only** - Login, checkout, key features
✅ **Use accessibility identifiers** - Not text that changes
✅ **Add waits for async** - `waitForExistence(timeout:)`
✅ **Keep tests independent** - Each test starts fresh
✅ **Handle splash screens** - Wait for them to finish
✅ **Avoid brittle selectors** - Text changes, IDs don't
