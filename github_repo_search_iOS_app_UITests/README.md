# UI Tests

Tests real user interactions on screen using XCUITest.

## What's in This Folder

### HomeViewUITests.swift (8 tests)

Tests actual user flows and visual elements.

Initial State:
- testHomeScreenInitialState - Splash screen to home screen with all elements

Search Field:
- testSearchFieldInteraction - Tap, type, clear search field
- testSearchFieldPlaceholder - Placeholder text exists

Search Results:
- testSearchResultsDisplay - Results appear after search
- testSearchResultsScroll - Can scroll through results list

Navigation:
- testNavigationBarTitle - Navigation bar shows correct title

States:
- testEmptyState - Initial empty state is valid

Expected duration: 60-90 seconds

## How to Run

After adding to Xcode project:

```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:UITests
```

Or in Xcode: Open Test Navigator, find UITests bundle, click run. You can watch the simulator perform the actions.

## Expected Results

All 8 tests should pass in about 60-90 seconds total.

## What You'll See

When UI tests run, the simulator will:
1. Launch the app
2. Wait for splash screen (3 seconds)
3. Navigate to home screen
4. Tap search field
5. Type "swift"
6. Display results
7. Scroll through list

It looks like a robot using your app.

## Purpose

UI tests verify that real user flows work end-to-end. They test what users actually see and do. These are the slowest tests but catch UX bugs.

Run these before releases to make sure everything works from a user perspective.

## When UI Tests Fail

Common reasons:
- Timing issues - Elements not loaded yet (increase timeout)
- Wrong selectors - Check accessibility IDs
- Slow performance - App takes too long to load
- Network issues - API slow or unavailable

Tips:
- Use waitForExistence with timeout instead of sleep
- Add accessibility identifiers to UI elements
- Check simulator performance
- Mock network calls for more reliable tests
