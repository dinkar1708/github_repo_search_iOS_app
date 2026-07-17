//
//  GithubRepository.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//  
//

import Foundation

/**
 Protocol to define all methods using modern Swift concurrency
 Sendable conformance, no @MainActor on business logic
 */
protocol GithubRepository: Sendable {
    // get search result in gitHub repository names
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse
}

/**
 Github repository for api calls using async/await
 Runs on background thread, no @MainActor
 */
final class DefaultGithubRepository: GithubRepository {
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse {
        // make query string with per page and page number
        let path = "\(queryString) in:\(HomeConstants.searchInRepositoryName)&per_page=\(perPage)&page=\(pageNumber)"
        return try await GithubAPI.searchRepoNames(requestObject: GithubAPI.SearchRepoRequest(query: path))
    }
}
