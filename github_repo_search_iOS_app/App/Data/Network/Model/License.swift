//
//  License.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/13.
//

/**
 Same as json data
 */
struct License: Decodable {
    let key, name, spdxID: String
    let url: String?
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
