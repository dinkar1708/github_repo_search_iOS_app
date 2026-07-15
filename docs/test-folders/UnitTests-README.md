# Unit Tests

## What This Folder Tests

**Purpose:** Test individual functions and classes in isolation, with no external dependencies.

**Framework:** XCTest (or Swift Testing for iOS 18+)

**Coverage Goal:** 80-90%

---

## Current Tests (4 tests)

### 1. API Repository Tests
**File:** `GitRepository_appTests.swift`

| Test Name | What It Tests | Status |
|-----------|---------------|--------|
| `testGetSearchResultInRepoNameSomeData` | API call with valid query returns results | ✅ Pass |
| `testGetSearchResultInRepoNameEmptyResult` | API call with special chars returns empty | ✅ Pass |
| `testGetSearchResultInRepoNameInvalidQuery` | API call with empty query throws error | ✅ Pass |

**Code Coverage:**
- `ApiClient.swift`: 88.89%
- `GithubRepository.swift`: Covered via these tests

### 2. ViewModel Tests (Optional - Not in Xcode yet)
**File:** `HomeViewModel_appTests.swift`

| Test Name | What It Tests | Status |
|-----------|---------------|--------|
| `testInitialState` | ViewModel starts with empty state | ⏳ Created |
| `testEmptySearchText` | Empty search clears results | ⏳ Created |
| `testMinimumCharacterRequirement` | Search requires 3+ characters | ⏳ Created |
| `testSearchTextAboveMinimum` | Search with 3+ chars triggers API | ⏳ Created |
| `testSearchTextChangesCancelsPreviousSearch` | New search cancels old one | ⏳ Created |
| `testClearingSearchTextResetsItems` | Clearing search removes results | ⏳ Created |

---

## How to Run

### Run All Unit Tests
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appTests
```

### Run Specific Test Class
```bash
# Run only API tests
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appTests/GithubRepository_appTests

# Run only ViewModel tests (when added to Xcode)
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appTests/HomeViewModel_appTests
```

### Run Specific Test
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appTests/GithubRepository_appTests/testGetSearchResultInRepoNameSomeData
```

### In Xcode
1. Open Test Navigator (⌘6)
2. Expand `github_repo_search_iOS_appTests`
3. Click ▶ next to any test or test class

---

## Latest Results

**Run Date:** 2026-07-15

**Result:** ✅ All tests passing (4/4)

**Execution Time:** ~2.6 seconds

**Code Coverage:**
```
Overall Unit Test Coverage: ~90%
- ApiClient.swift: 88.89% (32/36 lines)
- GithubRepository.swift: High coverage
- SearchRepoRequest.swift: Covered
- ApiResponseError.swift: Covered
```

**Test Output:**
```
Test Suite 'github_repo_search_iOS_appTests' passed
Executed 4 tests, with 0 failures in 2.660 seconds
```

---

## What Makes a Good Unit Test

✅ **Fast** - Runs in milliseconds
✅ **Isolated** - No network, no database, no file system
✅ **Repeatable** - Same input = same output, every time
✅ **Focused** - Tests one thing
✅ **Clear** - Test name explains what's being tested

---

## Adding New Tests

1. Create new test file in `github_repo_search_iOS_appTests/App/`
2. Import XCTest and your module:
```swift
import XCTest
@testable import github_repo_search_iOS_app

class MyNewTests: XCTestCase {
    func testSomething() {
        let result = MyClass().myMethod()
        XCTAssertEqual(result, expectedValue)
    }
}
```
3. Run tests with ⌘U

---

## Best Practices

- **Name pattern:** `test[WhatIsBeingTested][ExpectedOutcome]`
- **Arrange-Act-Assert:** Setup → Execute → Verify
- **One assertion per test** (when possible)
- **Mock external dependencies**
- **Test edge cases:** empty, nil, max values, errors
