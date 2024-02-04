//
//  HomeView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import SwiftUI
import Combine

/**
 Home view - display data for home screen
 */
struct HomeView: View {
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    init() {
        // customize table view, put it here not any global place, i want to customize this screen list only
        UITableViewCell.appearance().backgroundColor = .none
        UITableView.appearance().backgroundColor = Color.LightGray.uiColor()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                HeadView
                
                ZStack {
                    SearchResultView
                    MessageView
                }
            }
            .padding(.bottom, 2)
            // StackNavigationViewStyle set for iPad to run in full screen mode
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var HeadView: some View {
        // header view of home screen
        Group {
            Text("home_search_help_text").font(.smallText).padding(.top)
            AppSearchBar(text: $homeViewModel.searchText, textDidChanged: { text in
                homeViewModel.searchText = text
            }, placeholder: .constant("Search Repository"))
            .navigationBarTitle(Text("home_top_label"), displayMode: .inline)
        }
    }
    
    private var MessageView: some View {
        // display messages
        Group {
            switch homeViewModel.messageState {
            case .loading:
                AppProgressView()
            case .error(let error):
                ErrorView(title: error)
            case .emptySearchResult:
                NoDataEmptyView()
            case .loaded:
                EmptyView()
            }
        }
    }
    
    private var SearchResultView: some View {
        // show the search result, progress view if needed
        List {
            ForEach(homeViewModel.searchItems, id: \.self) { searchItem in
                SearchItemCell(name: searchItem.name).onAppear {
                    homeViewModel.searchForNextPage(currentItem: searchItem)
                }
                .background(NavigationLink(
                                destination: SearchItemDetailsView(searchItem: searchItem),
                                label: {
                                    EmptyView()
                                }))
            }
            if (homeViewModel.isSearchingCurrentPage && homeViewModel.searchItems.count > 0) {
                AppProgressView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
