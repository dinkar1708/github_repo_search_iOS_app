//
//  GithubRepository_appTests.swift
//  github_repo_search_iOS_appTests
//
//  Created by Dinakar Maurya on 2021/08/14.
//

import XCTest
@testable import github_repo_search_iOS_app

// gitHub repository test using modern async/await
@MainActor
class GithubRepository_appTests: XCTestCase {
    let gitHubRepository = DefaultGithubRepository()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGetSearchResultInRepoNameSomeData() async throws {
        do {
            let searchResponse = try await gitHubRepository.getSearchResultInRepoName(
                queryString: "swift",
                perPage: 60,
                pageNumber: 1
            )

            print("testGetSearchResultInRepoNameSomeData Total search results count \(searchResponse.totalCount)")
            print("testGetSearchResultInRepoNameSomeData Current Page search results count \(searchResponse.items.count)")

            XCTAssertTrue(searchResponse.totalCount > 0, "Expected search results but got \(searchResponse.totalCount)")
        } catch let error as ApiResponseError {
            XCTFail("API Error: \(error.message)")
        } catch {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testGetSearchResultInRepoNameEmptyResult() async throws {
        do {
            let searchResponse = try await gitHubRepository.getSearchResultInRepoName(
                queryString: "¥¥¥¥¥¥¥¥¥¥¥",
                perPage: 60,
                pageNumber: 1
            )

            print("testGetSearchResultInRepoNameEmptyResult Total search results count \(searchResponse.totalCount)")
            print("testGetSearchResultInRepoNameEmptyResult Current Page search results count \(searchResponse.items.count)")

            XCTAssertTrue(searchResponse.totalCount == 0, "Expected 0 results for invalid search")
        } catch let error as ApiResponseError {
            // Empty result might also come as error, which is acceptable
            print("API Error (expected for invalid search): \(error.message)")
        } catch {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testGetSearchResultInRepoNameInvalidQuery() async throws {
        do {
            let searchResponse = try await gitHubRepository.getSearchResultInRepoName(
                queryString: "",
                perPage: 60,
                pageNumber: 1
            )

            // If we get here without error, that's unexpected for empty query
            print("testGetSearchResultInRepoNameInvalidQuery Total search results count \(searchResponse.totalCount)")
            XCTFail("Expected error for empty query but got response")
        } catch let error as ApiResponseError {
            print("Received expected error: \(error.message)")
            XCTAssertTrue(error.message.contains("Validation Failed") || error.message.contains("missing"),
                         "Expected 'Validation Failed' error, got: \(error.message)")
        } catch {
            XCTFail("Unexpected error type: \(error.localizedDescription)")
        }
    }

}
