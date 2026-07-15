//
//  SearchRepoRequest.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation

/**
 GitHub API calls for search in repositories using modern Swift concurrency
 */
// MARK: - For git hub api calls For search in repo
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
     Reusable api client for api call using async/await
     */
    @MainActor
    static func searchRepoNames(requestObject: SearchRepoRequest) async throws -> SearchItemResponse {
        var urlRequest = requestObject.buildURLRequest()
        urlRequest.httpBody = requestObject.encodeRequestBody()
        let response: ApiClient.Response<SearchItemResponse> = try await sharedApiClient.run(urlRequest)
        return response.value
    }
}
