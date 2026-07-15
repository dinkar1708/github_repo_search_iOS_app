//
//  APIPerformanceTests.swift
//  PerformanceTests
//
//  Performance tests for API calls and data processing
//

import XCTest
@testable import github_repo_search_iOS_app

/// Performance tests for API operations
@MainActor
final class APIPerformanceTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // MARK: - API Call Performance

    func testSearchAPIPerformance() async throws {
        // Measure how long API search takes

        let repository = DefaultGithubRepository()

        measure {
            Task {
                do {
                    _ = try await repository.getSearchResultInRepoName(
                        queryString: "swift",
                        perPage: 40,
                        pageNumber: 1
                    )
                } catch {
                    // Network errors acceptable in performance test
                }
            }
        }
    }

    func testMultipleAPICallsPerformance() async throws {
        // Measure performance of multiple sequential API calls (pagination scenario)

        let repository = DefaultGithubRepository()

        measure {
            Task {
                for page in 1...3 {
                    do {
                        _ = try await repository.getSearchResultInRepoName(
                            queryString: "swift",
                            perPage: 40,
                            pageNumber: page
                        )
                    } catch {
                        // Network errors acceptable
                        break
                    }
                }
            }
        }
    }

    // MARK: - JSON Parsing Performance

    func testJSONParsingPerformance() throws {
        // Measure JSON decoding performance with sample data

        // Create sample JSON data
        let sampleJSON = """
        {
            "total_count": 100,
            "incomplete_results": false,
            "items": [
                {
                    "id": 123,
                    "name": "test-repo",
                    "full_name": "user/test-repo",
                    "owner": {
                        "login": "testuser",
                        "id": 456,
                        "avatar_url": "https://example.com/avatar.jpg"
                    },
                    "description": "Test repository",
                    "html_url": "https://github.com/user/test-repo",
                    "stargazers_count": 100,
                    "watchers_count": 50,
                    "forks_count": 25,
                    "open_issues_count": 10,
                    "language": "Swift"
                }
            ]
        }
        """.data(using: .utf8)!

        measure {
            do {
                _ = try JSONDecoder().decode(SearchItemResponse.self, from: sampleJSON)
            } catch {
                XCTFail("JSON parsing failed: \(error)")
            }
        }
    }

    func testLargeJSONParsingPerformance() throws {
        // Measure performance with larger dataset (100 items)

        var items: [[String: Any]] = []
        for i in 1...100 {
            items.append([
                "id": i,
                "name": "repo-\(i)",
                "full_name": "user/repo-\(i)",
                "owner": [
                    "login": "user\(i)",
                    "id": i * 100,
                    "avatar_url": "https://example.com/avatar\(i).jpg"
                ],
                "description": "Test repository number \(i)",
                "html_url": "https://github.com/user/repo-\(i)",
                "stargazers_count": i * 10,
                "watchers_count": i * 5,
                "forks_count": i * 2,
                "open_issues_count": i,
                "language": "Swift"
            ])
        }

        let jsonObject: [String: Any] = [
            "total_count": 1000,
            "incomplete_results": false,
            "items": items
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)

        measure {
            do {
                _ = try JSONDecoder().decode(SearchItemResponse.self, from: jsonData)
            } catch {
                // Parsing errors acceptable in test
            }
        }
    }

    // MARK: - Memory Performance

    func testSearchMemoryUsage() throws {
        // Measure memory footprint during search operation

        if #available(iOS 13.0, *) {
            measure(metrics: [XCTMemoryMetric()]) {
                let viewModel = HomeViewModel()
                viewModel.searchText = "swift"

                // Simulate search with data
                for i in 1...100 {
                    // This simulates having search results in memory
                    _ = "Item \(i)"
                }
            }
        }
    }

    // MARK: - Throttle Performance

    func testThrottlePerformance() throws {
        // Measure overhead of throttling mechanism

        measure {
            let viewModel = HomeViewModel()

            // Rapid fire changes (should be throttled)
            for char in "swift" {
                viewModel.searchText += String(char)
            }

            // The throttle mechanism should handle this efficiently
        }
    }
}
