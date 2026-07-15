# Integration Tests

Tests how multiple components work together.

## What's in This Folder

### SearchFlowIntegrationTests.swift (5 tests)

Tests complete search flows from ViewModel through API layer.

- testCompleteSearchFlow - Full flow from ViewModel to API to Results
- testSearchWithEmptyQuery - Empty query triggers validation error
- testSearchMinimumCharacterValidation - Minimum character requirement works
- testSearchThrottleMechanism - Throttle delays search correctly
- testSearchCancellation - Cancelling search stops API call

Expected duration: 25-30 seconds

## How to Run

After adding to Xcode project:

```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:IntegrationTests
```

Or in Xcode: Open Test Navigator, find IntegrationTests bundle, click run.

## Expected Results

All 5 tests should pass in about 25-30 seconds total.

Expected coverage:
- HomeViewModel.swift: around 75-80%
- GithubRepository.swift: around 85-90%
- ApiClient.swift: around 90-95%

## Purpose

Integration tests verify that components communicate correctly and data flows through layers properly. They make real API calls so they take longer than unit tests.

Run these before commits to catch integration bugs early.

## Example Flow

When you type "swift" in the search box:
1. HomeViewModel.searchText updates
2. Throttle waits 3 seconds
3. HomeViewModel calls GithubRepository
4. GithubRepository calls ApiClient
5. ApiClient makes HTTP request
6. Response parsed into models
7. HomeViewModel updates state
8. UI shows results

The testCompleteSearchFlow test verifies this entire flow works correctly.
