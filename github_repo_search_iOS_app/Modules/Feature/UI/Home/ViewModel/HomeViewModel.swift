//
//  HomeViewModel.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Combine
import SwiftUI
import Foundation

/**
 Home view model for data collections and operation
 Responsible for data change
 */
class HomeViewModel: ObservableObject {
    private let gitHubRepository = DefaultGithubRepository()
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var searchText:String = ""
    
    @Published private(set) var messageState: MessageState
    private var currentPage = HomeConstants.searchPageDefaultPage
    
    // stop trigger api call until current is in progress
    @Published var isSearchingCurrentPage = false
    // change only if trigger next page and get success result
    private var isSearchDataAvailableCurrentPage = true
    
    @Published var searchItems = [SearchItem]()
    
    init(state: MessageState = .loading) {
        // initialize state
        messageState = state
        // sink text change for api call
        $searchText
            // wait at least for below seconds to emit text
            .throttle(for: .seconds(HomeConstants.searchRepositoryThrottleTime), scheduler: DispatchQueue.main, latest: true)
            .filter{
                if($0.isEmpty) {
                    // show empty result, query is empty, api call not needed
                    self.messageState = .emptySearchResult
                    self.searchItems.removeAll()
                    return false
                }else {
                    return true
                }
            }
            .sink(receiveValue: {
                // reset initial value for new fresh search
                self.currentPage = HomeConstants.searchPageDefaultPage
                // clear items before in the list
                self.searchItems.removeAll()
                // get new search data
                self.searchInRepoNames(queryString: $0)
                
            })
            .store(in: &cancellableSet)
    }
    
    
    private func searchInRepoNames(queryString: String) {
        isSearchingCurrentPage = true
        
        // show loading only if it is fresh search start
        if searchItems.count == 0 {
            messageState = .loading
        }
        
        print("searchInRepoNames() for search query \(searchText) for page \(currentPage)")
        
        // get data from api
        gitHubRepository.getSearchResultInRepoName(queryString: queryString,
                                                   perPage: HomeConstants.searchPageSize, pageNumber: currentPage)
            .mapError({ (er) -> ApiResponseError in
                print(er.message)
                // display error on ui
                print("searchInRepoNames() error \(er.message)")
                self.messageState = .error(er.message)
                return er
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { searchResponse in
                    
                    print("searchInRepoNames() Total search results count \(searchResponse.totalCount)")
                    print("searchInRepoNames() current page results count \(searchResponse.items.count)")
                    
                    // special case when user searched some keyword and api is taking log time get data, but user clear the search text from search field, ignore the api result and show empty search result
                    if self.searchText.isEmpty {
                        print("searchInRepoNames() search query is empty ignore result.....")
                        self.searchItems.removeAll()
                        self.messageState = .emptySearchResult
                        return
                    }
                    
                    if searchResponse.totalCount <= 0 {
                        // empty result send on ui
                        self.messageState = .emptySearchResult
                        return
                    }
                    // send the loaded search result on ui
                    self.searchItems.append(contentsOf: searchResponse.items)
                    // item count is less than page size, it means no more items in the search text pages
                    self.isSearchDataAvailableCurrentPage = searchResponse.items.count >= HomeConstants.searchPageSize
                    print("searchInRepoNames()  total count so far \(self.searchItems.count)")
                    self.currentPage += 1
                    self.isSearchingCurrentPage = false
                    // change the state
                    self.messageState = .loaded
                  })
            .store(in: &cancellableSet)
    }
}

// MARK:- pagination
extension HomeViewModel {
    func searchForNextPage(currentItem: SearchItem) {
        // search for the next page data if can search
        let thresholdIndex = searchItems.index(searchItems.endIndex, offsetBy: HomeConstants.searchNextPageThreshold)
        if searchItems.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            searchNextPage()
        }
    }
    
    private func searchNextPage() {
        // search next page data if not loading and data available
        guard !isSearchingCurrentPage && isSearchDataAvailableCurrentPage else {
            return
        }
        searchInRepoNames(queryString: searchText)
    }
}

// MARK:- message state form view model
extension HomeViewModel {
    enum MessageState {
        case loading
        case loaded
        case error(String)
        case emptySearchResult
    }
}
