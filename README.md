# GitHub Repository Search iOS App

A modern, native iOS application for searching GitHub repositories with a beautiful, intuitive user interface built entirely with SwiftUI.

## Features

- Incremental search with real-time results
- No external libraries - 100% native iOS implementation
- API request throttling for optimal performance
- Modern iOS design with cards, gradients, and smooth animations
- Rich repository cards with avatars, stats, and descriptions
- Comprehensive detail view with full repository information
- Dark mode support with adaptive colors
- Multi-language support (English, Japanese)
- Universal app - supports iPhone and iPad

## Screenshots

<img width="350" height="750" alt="Simulator Screenshot - iPhone 17e - 2026-06-11 at 15 34 35" src="https://github.com/user-attachments/assets/d7bf4028-e22e-4b64-8c1b-0d8ec9e0c70e" />
<img width="350" height="750" alt="Simulator Screenshot - iPhone 17e - 2026-06-11 at 15 36 28" src="https://github.com/user-attachments/assets/170e1196-0279-4c4f-a4e2-6460bb3dbcbf" />
<img width="350" height="750" alt="Simulator Screenshot - iPhone 17e - 2026-06-11 at 15 35 49" src="https://github.com/user-attachments/assets/be540b62-effd-4e30-b235-c02645d134c4" />
<img width="350" height="750" alt="Simulator Screenshot - iPhone 17e - 2026-06-11 at 15 35 52" src="https://github.com/user-attachments/assets/c9f0303f-fb97-4d71-ba6e-cdadcbc98640" />


# Folder structure
<img width="349" alt="Screenshot 2024-02-04 at 20 56 26" src="https://github.com/dinkar1708/github_repo_search_iOS_app/assets/14831652/2d5da198-eabb-40bd-84cf-4e1893ddef57">
<img width="327" alt="Screenshot 2024-02-04 at 20 56 41" src="https://github.com/dinkar1708/github_repo_search_iOS_app/assets/14831652/a793a4db-8ed3-4ba5-aae4-c5c223c88356">


## UI Design

**Home Screen:**
- Gradient background with adaptive dark mode
- Real-time search with debouncing
- Rich repository cards with avatars, stats, and descriptions
- Empty states for initial, no results, errors, and loading
- Infinite scroll pagination

**Detail View:**
- Hero section with owner avatar and description
- Statistics grid (stars, forks, watchers, issues)
- Repository information (branch, license, dates, features)
- Action buttons (open in Safari, copy clone URL)

# Testing

## Quick Start
From Xcode, click **Product → Test** (or press `⌘U`) - it will run all test cases written inside:
- **github_repo_search_iOS_appTests** - Unit tests for business logic and API calls
- **github_repo_search_iOS_appUITests** - UI tests for user interaction flows

## 📖 Complete Testing Documentation
For detailed testing documentation including test cases, code coverage setup, and how to run tests, see:
**[docs/TESTING.md](docs/TESTING.md)**

This comprehensive guide includes:
- All test cases with detailed explanations
- Code coverage measurement and setup
- How to run tests (Xcode, command line, CI/CD)
- Test results interpretation
- Best practices and troubleshooting

## Code Coverage

**Quick Setup:**
1. Edit Scheme (`⌘<`) → Test → Options → Enable "Code Coverage"
2. Run tests (`⌘U`)
3. View results: Report Navigator (`⌘9`) → Coverage tab

**Coverage Goals:**
- Critical paths (API, business logic): 90-100%
- View models: 70-90%
- Overall target: 70%+

**View Coverage:**
- Green = well tested (>80%)
- Yellow = moderate (40-80%)
- Red = needs tests (<40%)

For detailed coverage documentation, command line usage, and best practices, see **[docs/TESTING.md](docs/TESTING.md)**
## Requirements

- **Xcode 15.0 or later** (latest version recommended)
- **iOS 17.0 or later** (minimum deployment target)
- **Swift 5.9 or later** (includes modern concurrency and Observation framework)

### How to run
- Clone this repo
- Open project in xcode
- Select team signing and capability

## Technology Stack

**Language:** Swift 5.9+ with modern concurrency

**UI:** SwiftUI with @main App lifecycle, AsyncImage, LazyVGrid, SF Symbols

**Architecture:** MVVM + Repository pattern

**Networking:** URLSession with async/await, type-safe ApiClient

**State:** @Observable macro (iOS 17+), @State, automatic change tracking

**Features:** Task-based debouncing, @MainActor, dark mode, accessibility, multi-language (EN/JP)

## Project Structure

```
App/
├── UI/           # Splash, Home, Details screens
├── Data/         # Models, Network, Repository
├── Util/         # Reusable utilities
└── Resources/    # Images, localization

AppConfig/        # Launch configuration
```

## Platform Support

**Languages:** English, Japanese
**Themes:** Light, Dark (adaptive)
**Devices:** iPhone, iPad (universal)
**Orientations:** Portrait, Landscape


# API handling - 
## API documentation
- https://developer.github.com/v3/search/
- GET /search/repositories
- Search for repo name https://api.github.com/search/repositories?q=swift%20in:name&per_page=40&page=1
## As per documentation : 
You need to successfully authenticate and have access to the repositories in your search queries, otherwise, you'll see a 422 Unprocessible Entry error with a "Validation Failed" message. For example, your search will fail if your query includes repo:, user:, or org: qualifiers that request resources that you don't have access to when you sign in on GitHub.
## Error handling of api
### Use below for error handling, if not passing any query
```
https://api.github.com/search/repositories?q=
{
  "message": "Validation Failed",
  "errors": [
    {
      "resource": "Search",
      "field": "q",
      "code": "missing"
    }
  ],
  "documentation_url": "https://docs.github.com/v3/search"
}

https://api.github.com/search/repositories?q=%20in:name
{
  "message": "Validation Failed",
  "errors": [
    {
      "message": "None of the search qualifiers apply to this search type.",
      "resource": "Search",
      "field": "q",
      "code": "invalid"
    }
  ],
  "documentation_url": "https://docs.github.com/v3/search/"
}
```
### error handling for invalid url, not found, search/repositories/  not valid url, valid is search/repositories
```
https://api.github.com/search/repositories/?q=%22swiftui%22
{
    "message": "Not Found",
    "documentation_url": "https://docs.github.com/rest"
}
```

## Key Highlights

**Modern iOS 17+ Features:**
- async/await throughout (no third-party frameworks)
- @Observable macro for reactive state
- Task-based debouncing and concurrency
- @MainActor for thread-safe UI updates
- SwiftUI @main App lifecycle

**Architecture:**
- MVVM design pattern
- Repository pattern for data abstraction
- Type-safe networking with URLSession
- Structured error handling
- Clean separation of concerns

## TODO List

- [ ] Complete all unit test cases
- [ ] Complete all UI test cases
- [ ] Add CI/CD pipeline (Bitrise/Fastlane)
- [ ] Implement comprehensive logging system
- [ ] Add pull-to-refresh on home screen
- [ ] Implement search history
- [ ] Add favorites/bookmarks feature
- [ ] Replace placeholder app icon with custom design
- [ ] Add animation transitions between screens
- [ ] Implement caching for offline support

# Meta
- Dinakar Maurya
- dinkar1708@gmail.com
