//
//  SearchItemResponse.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

/**
 Search item response data
 */
struct SearchItemResponse: Decodable, ApiResponse {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchItem]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
