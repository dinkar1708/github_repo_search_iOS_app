//
//  ApiClient.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation
import SwiftUI

/**
 Reusable api client for api call using modern Swift concurrency
 */
struct ApiClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    @MainActor
    func run<T: Decodable>(_ request: URLRequest) async throws -> Response<T> {
        print("APIClient API URL \(String(describing: request.url))")
        print("APIClient API method \(String(describing: request.httpMethod))")
        print("APIClient API json body")
        print(request.httpBody?.prettyJson ?? "")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            print("APIClient API URL incoming: \(String(describing: request.url))")
            print("APIClient API response incoming: ")
            // uncomment to see the data, lots of data so commenting it
            // print(String(data: data, encoding: .utf8) ?? "")

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                let value = try decoder.decode(T.self, from: data)
                return Response(value: value, response: response)
            } catch {
                print("APIClient Error : Converting to model error!, JSONDecoder decode failed!, parsing custom error...")
                print(error)
                print(error.localizedDescription)
                throw try JSONDecoder().decode(ApiResponseError.self, from: data)
            }
        } catch let error as ApiResponseError {
            print("APIClient Error : API response error!")
            print(error.message)
            throw error
        } catch {
            print("APIClient Error : Network error!")
            print(error.localizedDescription)
            throw ApiResponseError(message: error.localizedDescription)
        }
    }
}
