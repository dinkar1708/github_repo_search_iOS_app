# Performance Tests

## What This Folder Tests

**Purpose:** Measure speed, memory usage, CPU, and catch performance regressions.

**Framework:** XCTest (XCTMetrics)

**Coverage Goal:** Critical operations and bottlenecks

---

## Current Tests (1 test)

**File:** `github_repo_search_iOS_appUITests.swift`

| Test Name | What It Measures | Baseline | Status |
|-----------|------------------|----------|--------|
| `testLaunchPerformance` | App launch time (cold start) | ~1.37s | ✅ Pass |

**Metrics Captured:**
- `XCTApplicationLaunchMetric` - Time from tap to fully loaded

---

## How to Run

### Run All Performance Tests
```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:github_repo_search_iOS_appUITests/github_repo_search_iOS_appUITests/testLaunchPerformance
```

### In Xcode
1. Open Test Navigator (⌘6)
2. Find `github_repo_search_iOS_appUITests`
3. Click ▶ next to `testLaunchPerformance`
4. View metrics in test report

---

## Latest Results

**Run Date:** 2026-07-15

**Result:** ✅ Passing

**Execution Time:** ~26 seconds (runs 5 iterations)

### Launch Performance Metrics
```
Test Case 'testLaunchPerformance' measured:
[Duration (AppLaunch), s]
  Average: 1.367
  Std Deviation: 2.959%
  Values: [1.409, 1.310, 1.412, 1.334, 1.373]

Baseline: None set
Max Regression: 10.000%
Max Std Deviation: 10.000%
```

**Interpretation:**
- App launches in ~1.37 seconds on average
- Consistent performance (low std deviation)
- Well under 2-second target for good UX

---

## How Performance Tests Work

### 1. Run Multiple Iterations
Performance tests run 5-10 times to get stable average:
```swift
measure(metrics: [XCTClockMetric()]) {
    // Code to measure runs multiple times
}
```

### 2. Set Baseline
First run establishes baseline. Future runs compare against it.

### 3. Fail on Regression
If performance degrades beyond threshold (default 10%), test fails.

---

## Available Metrics

| Metric | What It Measures |
|--------|------------------|
| `XCTClockMetric` | Wall clock time |
| `XCTCPUMetric` | CPU cycles used |
| `XCTMemoryMetric` | Memory allocated |
| `XCTStorageMetric` | Disk writes |
| `XCTApplicationLaunchMetric` | App launch time |

---

## Example Performance Tests

### Test API Parsing Speed
```swift
import XCTest
@testable import github_repo_search_iOS_app

class APIPerformanceTests: XCTestCase {
    func testJSONParsingSpeed() {
        let jsonData = TestFixtures.largeSearchResponse

        measure(metrics: [XCTClockMetric(), XCTMemoryMetric()]) {
            _ = try? JSONDecoder().decode(SearchItemResponse.self, from: jsonData)
        }
    }
}
```

### Test Search Performance
```swift
func testSearchPerformance() {
    let viewModel = HomeViewModel()

    measure(metrics: [XCTClockMetric()]) {
        viewModel.searchText = "swift"
        // Wait for throttle
        Thread.sleep(forTimeInterval: 3.1)
    }
}
```

---

## Setting Baselines

**In Xcode:**
1. Run performance test
2. Click test in Test Navigator
3. Click "Set Baseline" in test report
4. Future runs compare against this baseline

**Test fails if:**
- Performance regresses > 10% (configurable)
- Std deviation > 10% (too inconsistent)

---

## Best Practices

✅ **Test on real device** - Simulator performance varies
✅ **Run on same device** - Different hardware = different baselines
✅ **Close other apps** - Reduce noise in measurements
✅ **Test critical paths** - App launch, data loading, heavy computations
✅ **Set realistic thresholds** - 10% regression is reasonable
✅ **Review on CI** - Catch regressions in pull requests

---

## Performance Targets (General Guidelines)

| Operation | Target | Threshold |
|-----------|--------|-----------|
| App Launch | < 2s | Good UX |
| API Response | < 1s | Feels instant |
| Screen Transition | < 0.3s | Smooth |
| List Scroll | 60 fps | No jank |
| Search Throttle | 0.3-1s | Balance |

---

## Adding New Performance Tests

1. Create test in performance test file
2. Use `measure(metrics:)` block
3. Run test 5+ times to establish baseline
4. Set baseline in Xcode
5. Monitor for regressions in CI/CD
