//
//  GithubRepository.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Combine

/**
 Protocol to define all methods
 */
protocol GithubRepository {
    // get search result in gitHub repository names
    func getSearchResultInRepoName(queryString: String, perPage:Int, pageNumber:Int)-> AnyPublisher<SearchItemResponse, ApiResponseError>
}

/**
 Github repository for api calls
 */
class DefaultGithubRepository: GithubRepository {
    func getSearchResultInRepoName(queryString: String, perPage:Int, pageNumber:Int) -> AnyPublisher<SearchItemResponse, ApiResponseError> {
        // make query string with per page and page number
        let path = "\(queryString) in:\(HomeConstants.searchInRepositoryName)&per_page=\(HomeConstants.searchPageSize)&page=\(pageNumber)"
        return GithubAPI.searchRepoNames(requestObject: GithubAPI.SearchRepoRequest(query: path))
            .eraseToAnyPublisher()
    }
}
