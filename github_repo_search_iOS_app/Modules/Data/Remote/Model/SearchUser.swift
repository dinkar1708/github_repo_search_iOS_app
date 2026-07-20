//
//  SearchUser.swift
//  github_repo_search_iOS_app
//
//  Created for User Search feature
//

import Foundation

/// Response model for user search API (API-1)
struct SearchUser: Codable, Sendable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

/// User model for search results
struct User: Codable, Sendable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let type: String
    let score: Double?

    enum CodingKeys: String, CodingKey {
        case id, login, type, score
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}
