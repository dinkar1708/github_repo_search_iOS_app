//
//  ApiClient.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//  
//

import Foundation
import SwiftUI

/**
 Reusable api client for api call using modern Swift concurrency
 No @MainActor, Sendable conformance, HTTP status validation
 */
struct ApiClient: Sendable {
    struct Response<T>: Sendable where T: Sendable {
        let value: T
        let response: URLResponse
        let statusCode: Int
    }

    private let session: URLSession

    init(timeoutInterval: TimeInterval = 30) {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutInterval
        config.timeoutIntervalForResource = timeoutInterval * 2
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
    }

    func run<T: Decodable & Sendable>(_ request: URLRequest) async throws -> Response<T> {
        print("APIClient API URL \(String(describing: request.url))")
        print("APIClient API method \(String(describing: request.httpMethod))")
        print("APIClient API json body")
        print(request.httpBody?.prettyJson ?? "")

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiResponseError(message: "Invalid response type")
            }

            print("APIClient API URL incoming: \(String(describing: request.url))")
            print("APIClient API status: \(httpResponse.statusCode)")

            // Validate HTTP status code
            guard (200...299).contains(httpResponse.statusCode) else {
                let message = "HTTP \(httpResponse.statusCode)"
                print("APIClient Error: \(message)")
                throw ApiResponseError(message: message)
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                let value = try decoder.decode(T.self, from: data)
                return Response(value: value, response: response, statusCode: httpResponse.statusCode)
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
