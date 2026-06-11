//
//  HomeView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import SwiftUI
import Combine

/**
 Home view - display data for home screen with modern iOS design
 */
struct HomeView: View {
    @ObservedObject private var homeViewModel = HomeViewModel()

    init() {
        // customize table view for modern appearance
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.systemBackground),
                        Color(UIColor.systemGray6)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    headerView

                    // Content
                    ZStack {
                        SearchResultView
                        MessageView
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("GitHub Search")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var headerView: some View {
        VStack(spacing: 16) {
            // App title
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Repository Search")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Search millions of GitHub repos")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // Search bar (already has magnifying glass icon built-in)
            AppSearchBar(
                text: $homeViewModel.searchText,
                textDidChanged: { _ in
                    // Text is already updated via binding, no need to set again
                    // ViewModel's Combine throttle will handle the API calls
                },
                placeholder: .constant("Search repositories...")
            )
            .padding(.horizontal)

            // Results count if available
            if !homeViewModel.searchItems.isEmpty {
                HStack {
                    Text("\(homeViewModel.searchItems.count) repositories found")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 12)
        .background(
            Color(UIColor.systemBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }

    private var MessageView: some View {
        // display messages
        Group {
            switch homeViewModel.messageState {
            case .loading:
                VStack(spacing: 20) {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Searching repositories...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            case .error(let error):
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                    Text("Error")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(error)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            case .emptySearchResult:
                VStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("No Repositories Found")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Try adjusting your search terms")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            case .loaded:
                if homeViewModel.searchItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "book.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        Text("Start Searching")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Enter a repository name to begin")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    EmptyView()
                }
            }
        }
    }

    private var SearchResultView: some View {
        // show the search result with modern card design
        List {
            ForEach(homeViewModel.searchItems, id: \.self) { searchItem in
                SearchItemCell(searchItem: searchItem)
                    .onAppear {
                        homeViewModel.searchForNextPage(currentItem: searchItem)
                    }
                    .background(
                        NavigationLink(
                            destination: SearchItemDetailsView(searchItem: searchItem),
                            label: { EmptyView() }
                        )
                        .opacity(0)
                    )
            }

            // Loading indicator for pagination
            if homeViewModel.isSearchingCurrentPage && homeViewModel.searchItems.count > 0 {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Loading more...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
