//
//  UserRepository.swift
//  github_repo_search_iOS_app
//
//  Created for User Repositories feature
//

import Foundation

/// User repository model for API-3 (Get User Repositories)
struct UserRepository: Decodable, Sendable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let htmlUrl: String
    let description: String?
    let fork: Bool
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let language: String?
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id, name, owner, description, fork, language
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case defaultBranch = "default_branch"
    }
}
