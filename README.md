# Requirement - Github repository search
# Features:
- [ ] Please implement incremental search
- [ ] Please do not use any libraries
- [ ] Please add API request throttling
- [ ] The design can be as simple as you like

# Demo - 
Request for access if needed, some videos and various screen shots on different devices - dark mode, japanese language set on phone etc.
- https://drive.google.com/drive/folders/1uwpVr0eZ3fh55vaala3djg2azkx2hJXy

# Main GUI
- Search name -
 <img src="https://user-images.githubusercontent.com/14831652/129710622-99dd0b92-ab4f-4c6c-975a-01b4c1fd3c60.jpeg" alt="Search Screen Light Mode" width="300" >
- Search name dark mode 
 <img src="https://user-images.githubusercontent.com/14831652/129710745-2dcebf1b-6a84-4f0a-bef8-a8435332352b.jpeg" alt="Search Screen Dark Mode" width="300" >
- Search name iPAD
 <img src="https://user-images.githubusercontent.com/14831652/129705497-a74f8ffa-bbc0-466d-a0f7-cd37e375c78a.png" alt="Search Screen Dark Mode" width="400" > 

# Implemented Features:
- [ ] Splash
- [ ] Home - show the search feature in gitHub repository names
- [ ] Search items details
- [ ] Unit Test case
- [ ] UI Test cases

# Testing From xcode click product-> Test - it will run all test case wrote inside below
- github_repo_search_iOS_appTests
- github_repo_search_iOS_appUITests
# Requirements
- xCode 12.3 (Developed)
- iOS 13 (minimum support version)
- Swift 4.0

### How to run
- Clone this repo
- Open project in xcode
- Select team signing and capability

## Code
- MVVM design pattern
- SwiftUI - used for UI development
- Swift - used for logical part

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

# TODO
- Complete all unit test case
- Complete all ui test cases
- Add CI/CD - bitrise/deploygate/fastlane
- Remove all prints statements
- Implement some logger to write logs on file, don't write logs in release mode
- Check gitHub api response format - check for all nil fields
- Implement search items details screen with more info
- Replace attractive app icons

# Meta
- Dinakar Maurya
- dinkar1708@gmail.com
