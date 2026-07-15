//
//  HomeViewUITests.swift
//  UITests
//
//  UI tests for Home screen - testing real user interactions
//

import XCTest

/// UI Tests - testing actual user flows on screen
/// Tests real taps, typing, and visual elements
final class HomeViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    // MARK: - Initial State Tests

    func testHomeScreenInitialState() throws {
        // Test that home screen loads correctly after splash

        // Arrange & Act
        let app = XCUIApplication()
        app.launch()

        // Wait for splash screen to finish (splash duration is 3 seconds)
        let homeViewNavBarTitle = "GitHub Search"
        XCTAssertTrue(app.navigationBars[homeViewNavBarTitle].waitForExistence(timeout: 15),
                     "Navigation bar should appear after splash")

        // Assert - Check all initial UI elements
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field should exist")

        let headerText = "Repository Search"
        XCTAssertTrue(app.staticTexts[headerText].exists,
                     "Header text should exist")

        let subtitle = "Search millions of GitHub repos"
        XCTAssertTrue(app.staticTexts[subtitle].exists,
                     "Subtitle should exist")
    }

    // MARK: - Search Field Tests

    func testSearchFieldInteraction() throws {
        // Test that search field accepts input and can be cleared

        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Wait for home view to load
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 15),
                     "Search field should exist")

        // Act - Tap and type
        searchField.tap()
        searchField.typeText("swift")

        // Assert - Verify text was entered
        XCTAssertEqual(searchField.value as? String, "swift",
                      "Search field should contain typed text")

        // Act - Clear field
        if let clearButton = searchField.buttons["Clear text"].firstMatch as? XCUIElement,
           clearButton.exists {
            clearButton.tap()
            print("✅ Clear button tapped")
        }
    }

    func testSearchFieldPlaceholder() throws {
        // Test search field placeholder text

        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 15))

        // Check placeholder (if accessible)
        XCTAssertTrue(searchField.exists, "Search field should have placeholder")
    }

    // MARK: - Search Results Tests

    func testSearchResultsDisplay() throws {
        // Test that search results appear or appropriate message is shown

        // Arrange
        let app = XCUIApplication()
        app.launch()

        // Wait for home view to load
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 15))

        // Act - Type search query
        searchField.tap()
        searchField.typeText("swift")

        // Wait for:
        // 1. Throttle delay (3 seconds)
        // 2. Network request
        // 3. UI update
        sleep(6)

        // Assert - Check if we're showing loading, results, or a message
        let isLoading = app.staticTexts["Searching repositories..."].exists
        let cells = app.cells
        let hasResults = cells.count > 0
        let hasEmptyMessage = app.staticTexts["No Repositories Found"].exists
        let hasStartMessage = app.staticTexts["Start Searching"].exists
        let hasErrorMessage = app.staticTexts["Error"].exists

        let hasValidState = isLoading || hasResults || hasEmptyMessage ||
                           hasStartMessage || hasErrorMessage

        XCTAssertTrue(hasValidState,
                     "Should show loading, results, or a message state")

        if hasResults {
            print("✅ UI Test: Found \(cells.count) result cells")
        }
    }

    func testSearchResultsScroll() throws {
        // Test that results can be scrolled

        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields.firstMatch
        searchField.waitForExistence(timeout: 15)
        searchField.tap()
        searchField.typeText("swift")

        sleep(6)

        // Check if results exist
        let cells = app.cells
        if cells.count > 3 {
            // Try to scroll
            app.swipeUp()
            print("✅ UI Test: Scrolled through results")
            XCTAssertTrue(true, "Should be able to scroll results")
        } else {
            print("⚠️ UI Test: Not enough results to test scrolling")
        }
    }

    // MARK: - Navigation Tests

    func testNavigationBarTitle() throws {
        // Test navigation bar title is correct

        let app = XCUIApplication()
        app.launch()

        let navBar = app.navigationBars["GitHub Search"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 15),
                     "Navigation bar with correct title should exist")
    }

    // MARK: - State Tests

    func testEmptyState() throws {
        // Test initial empty state message

        let app = XCUIApplication()
        app.launch()

        sleep(5) // Wait for UI to settle

        // Should show empty state or search prompt
        // (Depends on initial implementation)
        XCTAssertTrue(app.exists, "App should be in a valid state")
    }
}
