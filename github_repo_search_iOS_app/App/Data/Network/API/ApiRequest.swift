//
//  ApiRequest.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation

/**
 Api request basics eg path, method, url etc.
 */
protocol ApiRequest {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var urlParameters:[String : Any] { get }
    func encodeRequestBody() -> Data
}

// MARK:- Api call common methods default implementation
extension ApiRequest {
    var baseUrl: URL {
        return GithubAPI.appBaseUrl
    }
    var method: HttpMethod {
        .get
    }
    
    func encodeRequestBody() -> Data {
        return Data()
    }
    
    var urlParameters: [String : Any] {
        return [:]
    }
    
    func buildURLRequest() -> URLRequest {

        let completePath: URL = baseUrl.appendingPathComponent(path)
        guard var components = URLComponents(url: completePath, resolvingAgainstBaseURL: true)
        else { fatalError("URLComponents can not be created!") }
       
        if (!urlParameters.isEmpty) {
            components.queryItems = urlParameters.reversed().map { key, value in
                URLQueryItem.init(name: key, value: "\(value)")
            }
        }
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "%3D", with: "=")
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "%26", with: "&")
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return request
    }
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}
