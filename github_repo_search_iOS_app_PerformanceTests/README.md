# Performance Tests

Tests speed, memory usage, and app responsiveness using XCTMetrics.

## What's in This Folder

### AppLaunchPerformanceTests.swift (6 tests)

Tests app launch speed and resource usage.

- testAppLaunchTime - Time from tap to first screen
- testAppLaunchMemory - Memory used during launch
- testAppLaunchCPU - CPU usage during launch
- testColdStartVsWarmStart - Compare first launch vs subsequent
- testSplashScreenDuration - Splash screen timing (should be around 3s)
- testTimeToInteractive - Time until user can interact

Expected duration: 2-3 minutes

### APIPerformanceTests.swift (7 tests)

Tests network and data processing performance.

- testAPICallDuration - Time for single API call
- testAPICallUnderLoad - Performance with rapid requests
- testJSONParsingSmallResponse - Parse 10 items
- testJSONParsingLargeResponse - Parse 100+ items
- testMemoryDuringAPICall - Memory usage during network
- testThrottleOverhead - Cost of throttle mechanism
- testSearchResponseTime - End-to-end search speed

Expected duration: 3-5 minutes

## How to Run

After adding to Xcode project:

```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:PerformanceTests
```

Or in Xcode: Open Test Navigator, find PerformanceTests bundle, click run. Wait for all iterations to complete.

## Expected Results

All 13 tests should pass in about 5-7 minutes total.

Sample output:
- App launch time: Average 1.2s, StdDev 0.1s
- Launch memory: Average 42.5MB, StdDev 2.1MB
- API call duration: Average 1.8s, StdDev 0.3s
- JSON parsing (100 items): Average 0.04s, StdDev 0.008s

## Understanding Performance Tests

Each test runs 10 iterations by default:
- Collects 10 measurements
- Calculates average
- Calculates standard deviation
- Fails if variance too high (more than 10%)

## Setting Baselines

After first run:
1. Open Report Navigator in Xcode
2. Find the performance test
3. Click Set Baseline

Future runs will compare against baseline. Tests pass if within 10% of baseline, fail if regression more than 10%.

## When to Run

Performance tests are slow, so don't run them on every commit.

Run them:
- Before releases to catch performance regressions
- After major changes to verify no slowdown
- Periodically to track trends over time

Don't run them:
- On every commit (too slow)
- In PR checks (use CI/CD for main branch only)

## Performance Targets

Based on these tests:

App Launch: target under 1.5s, acceptable under 2.0s
Launch Memory: target under 40MB, acceptable under 50MB
API Call: target under 2.0s, acceptable under 3.0s
JSON Parse (100 items): target under 0.05s, acceptable under 0.10s
Search Response: target under 5.0s, acceptable under 7.0s

## Why 5-7 Minutes

This is normal for performance testing:
- 10 iterations per test
- 13 tests total
- Each test launches app or makes API calls
- Measurements need time to stabilize

## Debugging Slow Performance

If tests fail due to slow performance:

1. Check your network connection
2. Restart the simulator
3. Close other apps
4. Use Release build for accurate metrics
5. Check Instruments (Time Profiler, Allocations, Network)

Quick fixes:

```bash
# Use Release build
xcodebuild test -configuration Release ...

# Restart simulator
xcrun simctl shutdown all
xcrun simctl boot "iPhone 16"
```
