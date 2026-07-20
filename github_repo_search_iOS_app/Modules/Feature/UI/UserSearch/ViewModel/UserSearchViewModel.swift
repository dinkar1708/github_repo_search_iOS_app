//
//  UserSearchViewModel.swift
//  github_repo_search_iOS_app
//
//  Created for User Search feature (Feature 1.2)
//

import Foundation
import Observation

@Observable
@MainActor
final class UserSearchViewModel {
    private let repository: GithubRepository
    var users: [User] = []
    var isLoading = false
    var errorMessage: String?
    var searchText = ""
    var currentPage = 1
    var hasMorePages = true

    private var searchTask: Task<Void, Never>?

    init(repository: GithubRepository = DefaultGithubRepository()) {
        self.repository = repository
    }

    func searchUsers() {
        searchTask?.cancel()

        // Require minimum 2 characters
        guard !searchText.isEmpty, searchText.count >= 2 else {
            users = []
            currentPage = 1
            hasMorePages = true
            errorMessage = nil
            return
        }

        searchTask = Task {
            // Debounce: wait 800ms before searching
            try? await Task.sleep(for: .milliseconds(800))

            // Check if task was cancelled during sleep
            guard !Task.isCancelled else { return }

            // Reset state for new search
            isLoading = true
            errorMessage = nil
            currentPage = 1

            do {
                let response = try await repository.searchUsers(
                    query: searchText,
                    perPage: 30,
                    page: currentPage
                )

                // Check if cancelled after API call
                guard !Task.isCancelled else {
                    isLoading = false
                    return
                }

                users = response.items
                hasMorePages = response.items.count == 30
                isLoading = false
            } catch {
                // Only show error if task wasn't cancelled
                guard !Task.isCancelled else {
                    isLoading = false
                    return
                }
                errorMessage = error.localizedDescription
                users = []
                isLoading = false
            }
        }
    }

    func loadMoreUsers() {
        guard !isLoading, hasMorePages, !searchText.isEmpty else { return }

        Task {
            isLoading = true
            currentPage += 1

            do {
                let response = try await repository.searchUsers(
                    query: searchText,
                    perPage: 30,
                    page: currentPage
                )
                users.append(contentsOf: response.items)
                hasMorePages = response.items.count == 30
            } catch {
                errorMessage = error.localizedDescription
                currentPage -= 1
            }

            isLoading = false
        }
    }

    func refresh() {
        searchUsers()
    }
}
