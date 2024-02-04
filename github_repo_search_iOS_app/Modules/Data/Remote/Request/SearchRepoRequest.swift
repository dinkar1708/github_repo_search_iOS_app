//
//  SearchRepoRequest.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Combine

/**
 
 */
// MARK:- For git hub api calls For search in repo
extension GithubAPI {
    
    /**
     Search in repositories with specified query format
     */
    struct SearchRepoRequest: ApiRequest {
        var query: String
        var path: String { return "search/repositories" }
        var urlParameters: [String : Any] { return ["q": query]}
        var method: HttpMethod {
            .get
        }
    }
    
    /**
     Reusbale api client for api call
     */
    static func searchRepoNames(requestObject: SearchRepoRequest) -> AnyPublisher<SearchItemResponse, ApiResponseError> {
        var urlRequest = requestObject.buildURLRequest()
        urlRequest.httpBody = requestObject.encodeRequestBody()
        return sharedApiClient.run(urlRequest)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
