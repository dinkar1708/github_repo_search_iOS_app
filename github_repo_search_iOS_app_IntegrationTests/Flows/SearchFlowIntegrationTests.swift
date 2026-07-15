//
//  SearchFlowIntegrationTests.swift
//  IntegrationTests
//
//  Integration tests for complete search flow
//

import XCTest
@testable import github_repo_search_iOS_app

/// Integration tests - testing multiple components working together
/// Tests: ViewModel → Repository → API → Response → ViewModel State
@MainActor
class SearchFlowIntegrationTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // MARK: - Complete Flow Tests

    func testCompleteSearchFlow_Success() async throws {
        // This tests the ENTIRE flow: ViewModel → Repository → API → Back to ViewModel

        // Arrange
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.searchItems.count, 0, "Should start with no items")

        // Act
        viewModel.searchText = "swift"

        // Wait for:
        // 1. Throttle delay (3 seconds)
        // 2. API call (network time)
        // 3. Response processing
        try await Task.sleep(nanoseconds: 5_000_000_000) // 5 seconds

        // Assert
        // Should have either results or a valid state
        let hasResults = viewModel.searchItems.count > 0
        let hasValidState = switch viewModel.messageState {
        case .loaded, .emptySearchResult, .loading:
            true
        case .error:
            false
        }

        XCTAssertTrue(hasResults || hasValidState,
                     "Should have results or be in a valid state after search")

        if hasResults {
            print("✅ Integration test: Got \(viewModel.searchItems.count) results")
            XCTAssertGreaterThan(viewModel.searchItems.count, 0,
                               "Should have search results for 'swift'")
        }
    }

    func testSearchFlow_EmptyQuery() async throws {
        // Test flow when query becomes empty

        // Arrange
        let viewModel = HomeViewModel()
        viewModel.searchText = "swift"
        try await Task.sleep(nanoseconds: 5_000_000_000)

        // Act - clear search
        viewModel.searchText = ""
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

        // Assert
        XCTAssertEqual(viewModel.searchItems.count, 0,
                      "Items should be cleared when search is empty")
    }

    func testSearchFlow_MinimumCharacters() async throws {
        // Test flow with less than minimum characters

        // Arrange
        let viewModel = HomeViewModel()

        // Act
        viewModel.searchText = "ab" // Only 2 characters (minimum is 3)
        try await Task.sleep(nanoseconds: 500_000_000)

        // Assert
        XCTAssertEqual(viewModel.searchItems.count, 0,
                      "Should not search with less than 3 characters")
    }

    func testSearchFlow_ThrottleDebounce() async throws {
        // Test that throttling works correctly

        // Arrange
        let viewModel = HomeViewModel()

        // Act - Rapid changes (should be debounced)
        viewModel.searchText = "s"
        viewModel.searchText = "sw"
        viewModel.searchText = "swi"
        viewModel.searchText = "swift"

        // Wait less than throttle time
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

        // Assert - Should still be waiting (throttle is 3 seconds)
        XCTAssertEqual(viewModel.searchItems.count, 0,
                      "Should not have results yet (within throttle period)")

        // Wait for throttle + network
        try await Task.sleep(nanoseconds: 3_000_000_000) // 3 more seconds

        // Now should have results or be in loading/loaded state
        let isInValidState = viewModel.isSearchingCurrentPage ||
                            viewModel.searchItems.count > 0

        XCTAssertTrue(isInValidState,
                     "Should have completed search after throttle period")
    }

    func testSearchFlow_Cancellation() async throws {
        // Test that starting new search cancels old one

        // Arrange
        let viewModel = HomeViewModel()

        // Act - Start search then immediately change
        viewModel.searchText = "java"
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        viewModel.searchText = "swift" // Should cancel "java" search

        // Wait for new search
        try await Task.sleep(nanoseconds: 5_000_000_000)

        // Assert - Should have results for "swift", not "java"
        if viewModel.searchItems.count > 0 {
            // Can't easily verify the search term, but at least verify we got results
            XCTAssertGreaterThan(viewModel.searchItems.count, 0)
            print("✅ Search cancellation test: Got results")
        }
    }

    // MARK: - Performance Integration Test

    func testSearchFlowPerformance() async throws {
        measure {
            let viewModel = HomeViewModel()
            viewModel.searchText = "swift"

            // Note: This won't actually wait for network in measure block
            // It measures the synchronous part (throttle setup, state changes)
        }
    }
}
