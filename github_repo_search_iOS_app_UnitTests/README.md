# Unit Tests

Fast, isolated tests for individual functions and classes.

## What's in This Folder

### ApiClientTests.swift (4 tests)

Tests the core API client.

- testBuildURLWithValidQuery - URL building works correctly
- testBuildURLWithSpecialCharacters - Special characters are encoded
- testRequestMethodIsGET - HTTP method is set to GET
- testRequestIncludesRequiredHeaders - Required headers are included

Expected duration: 1-2 seconds

### GithubRepositoryTests.swift (4 tests)

Tests the GitHub repository API layer.

- testGetSearchResultWithValidQuery - Valid query returns results
- testGetSearchResultWithEmptyResult - Invalid query returns empty
- testGetSearchResultWithInvalidQuery - Empty query returns error
- testPerPageParameterIsUsed - Parameter is used, not hardcoded

Expected duration: 2-3 seconds

## How to Run

After adding to Xcode project:

```bash
xcodebuild test -scheme github_repo_search_iOS_app \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' \
  -only-testing:UnitTests
```

Or in Xcode: Open Test Navigator, find UnitTests bundle, click run.

## Expected Results

All 8 tests should pass in about 3-5 seconds total.

Expected coverage:
- ApiClient.swift: around 85-90%
- GithubRepository.swift: around 80-85%

## Purpose

Unit tests are fast and focused. They test one function or class at a time without network or UI. Run these frequently during development for quick feedback.
