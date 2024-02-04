//
//  ApiResponseError.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation
/**
 Reusable api error response type
 */
struct ApiResponseError: Error, Decodable {
    // handle error when errors is not null and null both
    var errors: [ApiError]?
    let message: String
    let documentation_url: String
    init(errors: [ApiError] = [], message: String = "Unknown Error!", documentation_url: String = "") {
        self.errors = errors
        self.message = message
        self.documentation_url = documentation_url
    }
}

/**
 Api error details
 */
struct ApiError: Decodable {
    let message: String
    let resource: String
    let field: String
    let code: String
    
    init(message: String, resource: String, field: String, code: String) {
        self.message = message
        self.resource = resource
        self.field = field
        self.code = code
    }
}
