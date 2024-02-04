//
//  ApiClient.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Combine
import SwiftUI

/**
 Reusable api client for api call
 */
struct ApiClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, ApiResponseError> {
        print("APIClient API URL \(String(describing: request.url))")
        print("APIClient API method \(String(describing: request.httpMethod))")
        print("APIClient API json body")
        print(request.httpBody?.prettyJson ?? "")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                print("APIClient API URL incoming: \(String(describing: request.url))")
                print("APIClient API response incoming: ")
                // uncomment to see the data, lots of data so commenting it
//                print(String(data: result.data, encoding: .utf8) ?? "")
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                    let value = try decoder.decode(T.self, from: result.data)
                    return Response(value: value, response: result.response)
                } catch let error {
                    print("APIClient Error : Converting to model error!, JSONDecoder decode failed!, parsing custom error...")
                    print(error)
                    print(error.localizedDescription)
                    throw try JSONDecoder().decode(ApiResponseError.self, from: result.data)
                }
            }
            // asynchronous with combine, get data on background scheduler, receive on main scheduler
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .mapError({ er in
                print("APIClient Error : mapError!")
                print(er.localizedDescription)
                return er as? ApiResponseError ?? ApiResponseError()
            })
            .eraseToAnyPublisher()
    }
}
