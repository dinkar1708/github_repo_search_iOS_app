# iOS App Features

Simple feature overview for the GitHub Repository Search iOS app.

## Core Features

### 1. Repository Search
- Search GitHub repositories by name
- Real-time search with 3-second debouncing
- Displays repository cards with stats
- Infinite scroll pagination

### 2. User Search
- Search GitHub users by username
- 800ms debounce for smooth searching
- View user cards with avatar and stats
- Tap to view detailed profile

### 3. User Profile
- View user details (name, bio, followers, following)
- List of user's repositories
- Favorite button to save user

### 4. Repository Details
- Comprehensive repository information
- Stats: stars, forks, watchers, issues
- Owner details
- Language, license, creation date
- Favorite button to save repository
- Open in GitHub button
- Copy clone URL

### 5. Favorites
- Save favorite users and repositories
- Segmented control (Users / Repositories)
- Swipe to delete
- Clear all option
- Persists with UserDefaults

### 6. Settings
- Dark mode toggle
- Language selection (English/Japanese)
- Clear cache
- App version info

## Technical Features

- **Native SwiftUI** - 100% native iOS, no external libraries
- **MVVM Architecture** - Clean separation of concerns
- **Async/Await** - Modern Swift concurrency
- **Dark Mode** - Full support with adaptive colors
- **Debouncing** - Optimized API calls
- **Caching** - Efficient data management

## API Integration

Uses GitHub REST API:
- Search repositories: `/search/repositories`
- Search users: `/search/users`
- User details: `/users/{username}`
- User repositories: `/users/{username}/repos`

For complete API documentation, see: [GitHub API Specification](https://github.com/dinkar1708/GithubCruiseAndroid/blob/main/docs/master/GITHUB_API_SPECIFICATION.md)
