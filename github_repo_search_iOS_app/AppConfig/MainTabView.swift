//
//  MainTabView.swift
//  github_repo_search_iOS_app
//
//  Created for Tab Navigation
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            UserSearchView()
                .tabItem {
                    Label("Users", systemImage: "person.circle")
                }
                .tag(0)

            HomeView()
                .tabItem {
                    Label("Repositories", systemImage: "folder")
                }
                .tag(1)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
