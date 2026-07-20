//
//  UserProfileViewModel.swift
//  github_repo_search_iOS_app
//
//  Created for User Profile feature (Feature 1.3)
//

import Foundation
import Observation

@Observable
@MainActor
final class UserProfileViewModel {
    private let repository: GithubRepository
    var userProfile: UserProfile?
    var userRepositories: [UserRepository] = []
    var isLoading = false
    var errorMessage: String?
    var showForksOnly = false

    init(repository: GithubRepository = DefaultGithubRepository()) {
        self.repository = repository
    }

    var filteredRepositories: [UserRepository] {
        if showForksOnly {
            return userRepositories.filter { $0.fork }
        }
        return userRepositories
    }

    func loadUserProfile(username: String) async {
        isLoading = true
        errorMessage = nil

        do {
            async let profile = repository.getUserProfile(username: username)
            async let repos = repository.getUserRepositories(username: username, perPage: 100, page: 1)

            userProfile = try await profile
            userRepositories = try await repos
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func refresh(username: String) async {
        await loadUserProfile(username: username)
    }

    func toggleForksFilter() {
        showForksOnly.toggle()
    }
}
