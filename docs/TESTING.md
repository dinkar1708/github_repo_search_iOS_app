# Testing Documentation

## Overview
Testing strategy and coverage for GitHub Repository Search iOS app.

**Current Status:**
- Unit Tests: 3/3 passing (100%)
- UI Tests: 1/3 implemented (33%)
- Performance Tests: 1/1 passing (100%)
- Integration Tests: Not implemented

---

## iOS Testing Types (Apple Guidelines)

According to Apple's official documentation, iOS apps should have:

### 1. Unit Tests
**Status:** Implemented
**Location:** `github_repo_search_iOS_appTests/`
**Purpose:** Test individual functions, methods, and classes in isolation

**Current Coverage:**
- API networking (`ApiClient.swift`)
- Repository pattern (`GithubRepository.swift`)
- Request building (`SearchRepoRequest.swift`)
- Error handling (`ApiResponseError.swift`)

**Example:** `GitRepository_appTests.swift` - Tests API calls and data parsing

### 2. UI Tests
**Status:** Partially Implemented
**Location:** `github_repo_search_iOS_appUITests/`
**Purpose:** Test user interface interactions and workflows

**Current Coverage:**
- Launch test (`testHomeHeadView`) - implemented
- Search field test - stub only
- Search results test - stub only

**Example:** `HomeView_appUITests.swift` - Tests UI elements exist

### 3. Performance Tests
**Status:** Implemented
**Location:** `github_repo_search_iOS_appUITests/github_repo_search_iOS_appUITests.swift`
**Purpose:** Measure app performance metrics

**Current Coverage:**
- Launch time measurement (`testLaunchPerformance`)

### 4. Integration Tests
**Status:** Not explicitly separated
**Purpose:** Test how multiple components work together

**Recommendation:** Consider adding tests for:
- View + ViewModel integration
- API + Repository + ViewModel flow
- Navigation flows

---

## Test Suite

### Location
`github_repo_search_iOS_appTests/App/Data/Network/Repository/GitRepository_appTests.swift`

### Our 3 Test Cases

**1. testGetSearchResultInRepoNameSomeData**
- Tests: Successful API calls with valid query
- Covers: `GithubRepository`, `ApiClient`, `SearchRepoRequest`, JSON parsing
- Expected: Returns results with count > 0

**2. testGetSearchResultInRepoNameEmptyResult**
- Tests: Searches returning no results
- Covers: Empty result handling, edge cases
- Expected: Returns empty or handles gracefully

**3. testGetSearchResultInRepoNameInvalidQuery**
- Tests: Invalid requests (empty query)
- Covers: Error handling, validation errors
- Expected: Throws validation error

### Technology
- XCTest framework with async/await
- @MainActor for thread safety
- All tests use modern Swift concurrency

---

## What's Covered

**Files Tested:**
- `ApiClient.swift` - Networking layer
- `GithubRepository.swift` - Repository pattern
- `SearchRepoRequest.swift` - API requests
- `ApiResponseError.swift` - Error handling

**Not Yet Covered:**
- UI Views, View Models, Navigation

---

## Recent Improvements (July 2026)

**Bug Fixes:**
- Fixed `GithubRepository.swift` to use `perPage` parameter instead of hardcoded constant
- Updated test query from "swiftmvvmin:name" to "swift" for more reliable results
- All 3 tests now passing consistently

**Status:** All tests passing (100% success rate)

---

## Code Coverage

### What It Is
Measures % of code executed during tests. Helps find untested areas.

**Important Philosophy:**
> 100% code coverage ≠ 100% test coverage
>
> A line being executed doesn't mean its behavior was asserted. Code coverage shows which lines ran, not whether they were properly validated.

### Goals
- Networking & API: 90-100%
- Business Logic: 80-90%
- Overall: 70%+

### How to Enable
**Xcode:** Edit Scheme (⌘<) → Test → Options → Check "Code Coverage"

### How to View
1. Press ⌘9 (Report Navigator)
2. Select test run
3. Click "Coverage" tab
4. See file percentages (green = good, red = needs tests)

### CLI Tool: xccov
Generate coverage reports from command line:
```bash
# View help
xcrun xccov --help
man xccov

# After running tests with coverage enabled
xcrun xccov view --report /path/to/test.xcresult
```

**Note:** xccov has no web documentation - use `man xccov` for the official reference.

---

## Running Tests

### In Xcode (Easiest)
- **All tests:** Press ⌘U
- **One test:** Click diamond icon
- **Results:** ⌘6 (Test Navigator) or ⌘9 (Report Navigator)

### Command Line
```bash
# All tests
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6'

# With coverage
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -enableCodeCoverage YES

# Specific test class
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appTests/GithubRepository_appTests

# List available simulators
xcrun simctl list devices available
```

---

## Best Practices

- Test independence (no shared state)
- Descriptive test names
- Async/await (no callbacks)
- Arrange-Act-Assert pattern

---

## Troubleshooting

**Tests not running?** Clean build (⌘⇧K) and rebuild (⌘B)

**Coverage not showing?** Enable in scheme, re-run tests

**Tests timeout?** Check network or async/await usage

---

## Quick Start

1. Open Xcode
2. Press ⌘U (run tests)
3. Press ⌘9 → Coverage tab (view results)
4. Done!

---

## What's Missing (Recommendations)

Based on Apple's testing best practices:

1. **Complete UI Tests**
   - Test search field input
   - Test search results display
   - Test navigation flows
   - Test error states

2. **ViewModel Tests**
   - Test HomeViewModel logic
   - Test state changes
   - Test error handling

3. **Integration Tests**
   - Test complete user flows
   - Test API → Repository → ViewModel → View

4. **Snapshot Tests** (Optional)
   - Visual regression testing
   - UI consistency across devices

---

## Resources

### Official Apple Documentation

**Priority #1 - Code Coverage:**
1. [Determining how much code your tests cover](https://developer.apple.com/documentation/xcode/determining-how-much-code-your-tests-cover) - THE official coverage guide (enabling in scheme, reading reports, using coverage to guide test development)

**Testing Hub:**
2. [Test coverage / Testing topic hub](https://developer.apple.com/documentation/xcode/test-coverage) - Parent section covering logic failures, UI problems, performance regressions

**Testing Frameworks:**
3. [XCTest framework reference](https://developer.apple.com/documentation/xctest) - Traditional iOS testing framework
4. [Swift Testing framework reference](https://developer.apple.com/documentation/testing) - Modern Swift-native testing (iOS 18+)

**Command Line Tools:**
5. **xccov CLI** - No web page exists; run `man xccov` or `xcrun xccov --help` in Terminal for the official reference

### Key Insight

**Code Coverage ≠ Test Coverage**

Coverage measures execution, not validation. A line can be executed without its behavior being properly asserted. Use coverage to find untested paths, not as a score to maximize.
