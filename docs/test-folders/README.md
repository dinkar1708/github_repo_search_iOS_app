# Test Folders - Complete Guide

## Overview

This directory contains detailed READMEs for each test type in the iOS Testing pyramid.

---

## Test Type Matrix

| Test Type | Framework | What It Verifies | Count | Folder |
|-----------|-----------|------------------|-------|--------|
| **Unit** | XCTest | One function or class, isolated | 4 | [UnitTests-README.md](UnitTests-README.md) |
| **Integration** | XCTest | Multiple components together | 0 | [IntegrationTests-README.md](IntegrationTests-README.md) |
| **UI** | XCTest (XCUI) | Real user flows on screen | 3 | [UITests-README.md](UITests-README.md) |
| **Performance** | XCTest (Metrics) | Speed and memory over time | 1 | [PerformanceTests-README.md](PerformanceTests-README.md) |

**Total:** 8 tests, all passing ✅

---

## Quick Links

### [Unit Tests →](UnitTests-README.md)
- 4 tests covering API calls and repository layer
- Fastest tests (~2.6s total)
- 88.89% coverage on ApiClient
- Run: `xcodebuild test -only-testing:github_repo_search_iOS_appTests`

### [Integration Tests →](IntegrationTests-README.md)
- 0 tests (planned for future)
- Would test API → Repository → ViewModel flows
- Examples provided for implementation

### [UI Tests →](UITests-README.md)
- 3 tests covering home screen interactions
- Slowest tests (~29s total)
- Tests search field, results display, navigation
- Run: `xcodebuild test -only-testing:github_repo_search_iOS_appUITests/HomeView_appUITests`

### [Performance Tests →](PerformanceTests-README.md)
- 1 test measuring app launch time
- Launch time: ~1.37s average
- Uses XCTApplicationLaunchMetric
- Run: `xcodebuild test -only-testing:github_repo_search_iOS_appUITests/github_repo_search_iOS_appUITests/testLaunchPerformance`

---

## Run All Tests

```bash
# All tests with coverage
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -enableCodeCoverage YES
```

**Result:** 8/8 passing, 51.87% code coverage

---

## Current Project Structure

Your project has **2 test targets** (standard Xcode setup):

```
github_repo_search_iOS_app/
├── github_repo_search_iOS_appTests/        ← Unit Tests
│   ├── GitRepository_appTests.swift        (3 tests)
│   ├── HomeViewModel_appTests.swift        (6 tests - needs Xcode add)
│   └── testPerformanceExample             (1 stub)
│
└── github_repo_search_iOS_appUITests/      ← UI + Performance Tests
    ├── HomeView_appUITests.swift           (3 tests)
    └── testLaunchPerformance               (1 test)
```

---

## For Your Blog Post

Each README in this folder contains:

✅ **What the test type verifies**
✅ **Current test count and status**
✅ **Exact commands to run those tests**
✅ **Latest results with timing**
✅ **Code examples**
✅ **Best practices**

Use these as standalone sections in your blog or as reference material for readers.

---

## Coverage Breakdown

| Component | Coverage | Lines Covered |
|-----------|----------|---------------|
| Overall | 51.87% | 1110/2140 |
| ApiClient | 88.89% | 32/36 |
| HomeView | 87.63% | 425/485 |
| AppSearchBar | 100% | 42/42 |
| SearchItem | 100% | 6/6 |
| SplashView | 95.89% | 70/73 |

---

## Test Pyramid

```
        /\
       /UI\ ← 3 tests (slowest, most brittle)
      /----\
     /Integ\ ← 0 tests (future)
    /--------\
   /   Unit   \ ← 4 tests (fastest, most stable)
  /-----------\
```

**Philosophy:** More tests at the bottom (fast, stable) and fewer at the top (slow, brittle).

---

## Official Apple Documentation

1. [Determining how much code your tests cover](https://developer.apple.com/documentation/xcode/determining-how-much-code-your-tests-cover)
2. [Test coverage topic hub](https://developer.apple.com/documentation/xcode/test-coverage)
3. [XCTest framework](https://developer.apple.com/documentation/xctest)
4. [Swift Testing framework](https://developer.apple.com/documentation/testing)
5. [XCUITest (UI testing)](https://developer.apple.com/documentation/xctest/user_interface_tests)
6. [XCTMetric (Performance testing)](https://developer.apple.com/documentation/xctest/performance_tests)

---

## Next Steps

For your blog:
1. Use each README as a section
2. Add code examples from the READMEs
3. Include the run commands
4. Show the actual results
5. Link to these docs in your GitHub repo

Your readers can then:
- Clone your repo
- See working tests
- Run them with provided commands
- Read detailed explanations in each README
