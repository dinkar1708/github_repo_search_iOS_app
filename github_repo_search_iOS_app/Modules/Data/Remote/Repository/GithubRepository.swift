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
    // MARK: - Repository Search (existing)
    /// Search for repositories by name
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse

    // MARK: - User Search & Profile
    /// API-1: Search for users
    func searchUsers(query: String, perPage: Int, page: Int) async throws -> SearchUser

    /// API-2: Get user profile
    func getUserProfile(username: String) async throws -> UserProfile

    /// API-3: Get user repositories
    func getUserRepositories(username: String, perPage: Int, page: Int) async throws -> [UserRepository]
}

/**
 Github repository for api calls using async/await
 Runs on background thread, no @MainActor
 */
final class DefaultGithubRepository: GithubRepository {
    // MARK: - Repository Search (existing)
    func getSearchResultInRepoName(queryString: String, perPage: Int, pageNumber: Int) async throws -> SearchItemResponse {
        // make query string with per page and page number
        let path = "\(queryString) in:\(HomeConstants.searchInRepositoryName)&per_page=\(perPage)&page=\(pageNumber)"
        return try await GithubAPI.searchRepoNames(requestObject: GithubAPI.SearchRepoRequest(query: path))
    }

    // MARK: - User Search & Profile
    func searchUsers(query: String, perPage: Int, page: Int) async throws -> SearchUser {
        return try await GithubAPI.searchUsers(
            requestObject: GithubAPI.SearchUsersRequest(query: query, perPage: perPage, page: page)
        )
    }

    func getUserProfile(username: String) async throws -> UserProfile {
        return try await GithubAPI.getUserProfile(
            requestObject: GithubAPI.GetUserProfileRequest(username: username)
        )
    }

    func getUserRepositories(username: String, perPage: Int, page: Int) async throws -> [UserRepository] {
        return try await GithubAPI.getUserRepositories(
            requestObject: GithubAPI.GetUserRepositoriesRequest(username: username, perPage: perPage, page: page)
        )
    }
}
