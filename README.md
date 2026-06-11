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


## Modern UI Features

### Home Screen
The home screen features a clean, modern design with several key elements:
- Gradient background with system-adaptive colors that respond to light and dark mode
- Enhanced search header with clear title and subtitle
- Modern search bar with real-time feedback as you type
- Results counter showing the number of repositories found
- Beautiful empty states for different scenarios:
  - Initial state shows "Start Searching" with a book icon
  - No results state displays "No Repositories Found" with helpful suggestions
  - Error state provides detailed error information
  - Loading state shows an animated spinner with status text
- Infinite scroll pagination for seamless browsing of search results

### Repository Cards
Each repository is displayed as a rich card containing:
- Owner avatar displayed as a circular image with AsyncImage loading
- Repository name in bold, prominent text
- Owner username as secondary information
- Two-line preview of the repository description
- Language badge color-coded by programming language (Swift: Orange, Python: Blue, JavaScript: Yellow, etc.)
- Statistics row showing:
  - Star count with star icon
  - Fork count with fork icon
  - Watcher count with eye icon
- Modern card design with shadows, rounded corners, and clean spacing
- Chevron indicator for navigation

### Repository Detail View
The detail view provides comprehensive information about each repository:

Hero Section:
- Large owner avatar (100px circular image)
- Repository name and full path
- Complete description
- Language tag with color coding

Statistics Grid (2x2 layout):
- Stars displayed in yellow
- Forks displayed in blue
- Watchers displayed in green
- Open issues displayed in red

Repository Information Card:
- Owner details and profile
- Repository type (public/private)
- Default branch name
- Homepage URL if available
- License information
- Repository size in KB
- Creation and last update dates
- Feature badges showing Issues, Wiki, and Pages availability

Owner Details Section:
- Owner avatar and username
- Account type (User or Organization)
- Site admin indicator if applicable

Action Buttons:
- Open in GitHub button - Opens repository directly in Safari
- Copy Clone URL button - Copies the git clone URL to clipboard

## Implemented Features

- Splash screen with app branding
- Home screen with modern search interface and rich repository cards
- Repository details screen with comprehensive information display
- Unit tests covering business logic
- UI tests for user interaction flows

# Testing From xcode click product-> Test - it will run all test case wrote inside below
- github_repo_search_iOS_appTests
- github_repo_search_iOS_appUITests
## Requirements

- Xcode 14.0 or later (latest version recommended)
- iOS 15.0 or later (minimum deployment target)
- Swift 5.5 or later (includes async/await support)

### How to run
- Clone this repo
- Open project in xcode
- Select team signing and capability

## Technology Stack

### Architecture
The application follows the MVVM (Model-View-ViewModel) design pattern for clean separation of concerns. The data layer uses the Repository pattern for abstraction, and the Combine framework handles reactive programming for smooth data flow throughout the app.

### UI Framework
The entire user interface is built with SwiftUI using modern declarative UI patterns. Key UI components include:
- AsyncImage for native asynchronous image loading
- LazyVGrid for efficient grid layouts
- SF Symbols for consistent system icons

### Modern iOS Features
The app leverages several modern iOS capabilities:
- Environment values such as @Environment(\.openURL) for handling external links
- Adaptive colors providing full dark mode support
- System backgrounds following proper iOS design language
- Accessibility features including VoiceOver compatibility with semantic views

### Language and Tools
Built with Swift 5.5 and later, utilizing modern Swift features. The codebase is structured to support async/await patterns for future enhancements.

# Usages 
- Follow below folder structure and use the files 
## App - All features and data
- UI - screens UI
  - Splash
  - Home
  - Search Items Details
- Util - utils file reusable
- Data - Model class and data to be used in app, Network, Repository api calls etc.
- Resources - Image and localization files

## AppConfig - basics configuration launch time of app

# MEMO / NOTES

## Assumptions
- Need to check search result api all keys validations eg. if nil then need to change the declaration of variable as nil/?

## Env type
- Debug - for development purpose
- Inhouse - for testing purpose
- Release - release on app store

## Multi Language 
- English
- Japanese

## Theme Support available
- Light
- Dark

## Screen rotation handling implemented
- Design UI to handle / display UI on both portrait and landscape mode properly

## Multiple screen size implemented - Iphone, iPad
- Verified app on iPAD and different small and big size screens

## Verification of app performance / Profile
- Verify memory leaks, extra view hierarch etc. - https://developer.apple.com/documentation/xcode/diagnosing-and-resolving-bugs-in-your-running-app

## Documentation and code commenting for understanding other developer


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

## Recent Improvements

### UI and UX Enhancements
The application recently underwent a complete UI modernization to align with iOS 15+ design language. Key improvements include:
- Rich repository cards displaying avatars, descriptions, and statistics
- Comprehensive detail view organized into 5 distinct sections
- Beautiful empty states tailored for different scenarios (initial, no results, errors, loading)
- Modern navigation with proper title styles and hierarchy
- Action buttons for opening repositories in Safari and copying clone URLs
- Language color coding for visual programming language identification
- Professional card-based layout with shadows and proper spacing

### Technical Updates
Several technical improvements were implemented:
- Updated iOS deployment target to 15.0 to leverage latest platform features
- Integrated AsyncImage for native asynchronous image loading
- Implemented LazyVGrid layouts for efficient statistics display
- Added environment-based URL handling for modern link opening
- Applied semantic colors throughout for full dark mode support
- Fixed duplicate search icon issue
- Resolved duplicate API request issue when typing

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
