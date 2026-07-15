//
//  GithubRepository.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation

/**
 Protocol to define all methods using modern Swift concurrency
 */
protocol GithubRepository {
    // get search result in gitHub repository names
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse
}

/**
 Github repository for api calls using async/await
 */
class DefaultGithubRepository: GithubRepository {
    @MainActor
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse {
        // make query string with per page and page number
        let path = "\(queryString) in:\(HomeConstants.searchInRepositoryName)&per_page=\(HomeConstants.searchPageSize)&page=\(pageNumber)"
        return try await GithubAPI.searchRepoNames(requestObject: GithubAPI.SearchRepoRequest(query: path))
    }
}
