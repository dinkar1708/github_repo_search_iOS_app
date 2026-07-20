//
//  FavoritesManager.swift
//  github_repo_search_iOS_app
//
//  Created for Favorites feature (Feature 3.0)
//

import Foundation
import Observation

/// Simple model for storing favorite user data
struct FavoriteUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int

    init(from profile: UserProfile) {
        self.id = profile.id
        self.login = profile.login
        self.avatarUrl = profile.avatarUrl
        self.name = profile.name
        self.bio = profile.bio
        self.publicRepos = profile.publicRepos
        self.followers = profile.followers
        self.following = profile.following
    }
}

/// Simple model for storing favorite repository data
struct FavoriteRepository: Codable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let ownerLogin: String
    let ownerAvatarUrl: String
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int
    let htmlUrl: String

    // Additional fields needed for SearchItem reconstruction
    let ownerId: Int
    let cloneUrl: String
    let watchers: Int
    let openIssues: Int
    let createdAt: Date?

    init(from searchItem: SearchItem) {
        self.id = searchItem.id
        self.name = searchItem.name
        self.fullName = searchItem.fullName
        self.ownerLogin = searchItem.owner.login
        self.ownerAvatarUrl = searchItem.owner.avatarURL
        self.ownerId = searchItem.owner.id
        self.description = searchItem.itemDescription
        self.language = searchItem.language
        self.stargazersCount = searchItem.stargazersCount
        self.forksCount = searchItem.forksCount
        self.htmlUrl = searchItem.htmlURL
        self.cloneUrl = searchItem.cloneURL
        self.watchers = searchItem.watchers
        self.openIssues = searchItem.openIssues
        self.createdAt = searchItem.createdAt
    }

    /// Convert FavoriteRepository back to SearchItem for navigation
    func toSearchItem() -> SearchItem {
        // Create a minimal Owner object
        let owner = Owner(
            login: ownerLogin,
            id: ownerId,
            nodeID: "",
            avatarURL: ownerAvatarUrl,
            gravatarID: "",
            url: "",
            htmlURL: "",
            followersURL: "",
            followingURL: "",
            gistsURL: "",
            starredURL: "",
            subscriptionsURL: "",
            organizationsURL: "",
            reposURL: "",
            eventsURL: "",
            receivedEventsURL: "",
            type: "User",
            siteAdmin: false
        )

        // Create SearchItem with all required fields
        return SearchItem(
            id: id,
            nodeID: "",
            name: name,
            fullName: fullName,
            itemPrivate: false,
            owner: owner,
            htmlURL: htmlUrl,
            itemDescription: description,
            fork: false,
            url: "",
            forksURL: "",
            keysURL: "",
            collaboratorsURL: "",
            teamsURL: "",
            hooksURL: "",
            issueEventsURL: "",
            eventsURL: "",
            assigneesURL: "",
            branchesURL: "",
            tagsURL: "",
            blobsURL: "",
            gitTagsURL: "",
            gitRefsURL: "",
            treesURL: "",
            statusesURL: "",
            languagesURL: "",
            stargazersURL: "",
            contributorsURL: "",
            subscribersURL: "",
            subscriptionURL: "",
            commitsURL: "",
            gitCommitsURL: "",
            commentsURL: "",
            issueCommentURL: "",
            contentsURL: "",
            compareURL: "",
            mergesURL: "",
            archiveURL: "",
            downloadsURL: "",
            issuesURL: "",
            pullsURL: "",
            milestonesURL: "",
            notificationsURL: "",
            labelsURL: "",
            releasesURL: "",
            deploymentsURL: "",
            createdAt: createdAt,
            updatedAt: nil,
            pushedAt: nil,
            gitURL: "",
            sshURL: "",
            cloneURL: cloneUrl,
            svnURL: "",
            homepage: nil,
            size: 0,
            stargazersCount: stargazersCount,
            watchersCount: watchers,
            language: language,
            hasIssues: true,
            hasProjects: true,
            hasDownloads: true,
            hasWiki: true,
            hasPages: false,
            forksCount: forksCount,
            mirrorURL: nil,
            archived: false,
            disabled: false,
            openIssuesCount: openIssues,
            license: nil,
            forks: forksCount,
            openIssues: openIssues,
            watchers: watchers,
            defaultBranch: "main",
            score: 0
        )
    }
}

@Observable
@MainActor
final class FavoritesManager {
    static let shared = FavoritesManager()

    private let userFavoritesKey = "github_user_favorites"
    private let repoFavoritesKey = "github_repo_favorites"

    var favoriteUsers: [FavoriteUser] = []
    var favoriteRepositories: [FavoriteRepository] = []

    private init() {
        loadFavorites()
    }

    // MARK: - User Favorites

    func addFavoriteUser(profile: UserProfile) {
        let favorite = FavoriteUser(from: profile)

        // Avoid duplicates
        if !favoriteUsers.contains(where: { $0.id == favorite.id }) {
            favoriteUsers.append(favorite)
            saveFavorites()
        }
    }

    func removeFavoriteUser(username: String) {
        favoriteUsers.removeAll { $0.login == username }
        saveFavorites()
    }

    func isFavoriteUser(username: String) -> Bool {
        return favoriteUsers.contains { $0.login == username }
    }

    func clearAllUserFavorites() {
        favoriteUsers.removeAll()
        saveFavorites()
    }

    // MARK: - Repository Favorites

    func addFavoriteRepository(repository: SearchItem) {
        let favorite = FavoriteRepository(from: repository)

        // Avoid duplicates
        if !favoriteRepositories.contains(where: { $0.id == favorite.id }) {
            favoriteRepositories.append(favorite)
            saveFavorites()
        }
    }

    func removeFavoriteRepository(repositoryId: Int) {
        favoriteRepositories.removeAll { $0.id == repositoryId }
        saveFavorites()
    }

    func isFavoriteRepository(repositoryId: Int) -> Bool {
        return favoriteRepositories.contains { $0.id == repositoryId }
    }

    func clearAllRepositoryFavorites() {
        favoriteRepositories.removeAll()
        saveFavorites()
    }

    // MARK: - Clear All

    func clearAllFavorites() {
        favoriteUsers.removeAll()
        favoriteRepositories.removeAll()
        saveFavorites()
    }

    // MARK: - Persistence

    private func saveFavorites() {
        do {
            let encoder = JSONEncoder()

            // Save users
            let userData = try encoder.encode(favoriteUsers)
            UserDefaults.standard.set(userData, forKey: userFavoritesKey)

            // Save repositories
            let repoData = try encoder.encode(favoriteRepositories)
            UserDefaults.standard.set(repoData, forKey: repoFavoritesKey)
        } catch {
            print("Failed to save favorites: \(error.localizedDescription)")
        }
    }

    private func loadFavorites() {
        let decoder = JSONDecoder()

        // Load users
        if let userData = UserDefaults.standard.data(forKey: userFavoritesKey) {
            do {
                favoriteUsers = try decoder.decode([FavoriteUser].self, from: userData)
            } catch {
                print("Failed to load user favorites: \(error.localizedDescription)")
                favoriteUsers = []
            }
        }

        // Load repositories
        if let repoData = UserDefaults.standard.data(forKey: repoFavoritesKey) {
            do {
                favoriteRepositories = try decoder.decode([FavoriteRepository].self, from: repoData)
            } catch {
                print("Failed to load repository favorites: \(error.localizedDescription)")
                favoriteRepositories = []
            }
        }
    }

    // MARK: - Legacy Support

    // For backward compatibility with old favorites key
    @discardableResult
    func migrateLegacyFavorites() -> Bool {
        let legacyKey = "github_favorites"
        guard let data = UserDefaults.standard.data(forKey: legacyKey) else {
            return false
        }

        do {
            let decoder = JSONDecoder()
            let legacyFavorites = try decoder.decode([FavoriteUser].self, from: data)

            // Merge with existing favorites
            for legacy in legacyFavorites {
                if !favoriteUsers.contains(where: { $0.id == legacy.id }) {
                    favoriteUsers.append(legacy)
                }
            }

            saveFavorites()
            UserDefaults.standard.removeObject(forKey: legacyKey)
            return true
        } catch {
            print("Failed to migrate legacy favorites: \(error.localizedDescription)")
            return false
        }
    }
}
