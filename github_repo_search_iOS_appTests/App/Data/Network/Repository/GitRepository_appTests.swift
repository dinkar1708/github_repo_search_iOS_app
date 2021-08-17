//
//  GithubRepository_appTests.swift
//  github_repo_search_iOS_appTests
//
//  Created by Dinakar Maurya on 2021/08/14.
//

import XCTest
import Combine
@testable import github_repo_search_iOS_app

// gitHub repository test
class GithubRepository_appTests: XCTestCase {
    let gitHubRepository = DefaultGithubRepository()
    private var cancellableSet: Set<AnyCancellable> = []

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGetSearchResultInRepoNameSomeData() throws {
       gitHubRepository.getSearchResultInRepoName(queryString: "swiftmvvmin:name",
                                         perPage: 60, pageNumber: 1)
            .mapError({ (er) -> ApiResponseError in
                print(er.message)
                return er
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { serachResponse in
                    print("testGetSearchResultInRepoNameSomeData Total search results count \(serachResponse.totalCount)")
                    print("testGetSearchResultInRepoNameSomeData Current Page search results count \(serachResponse.items.count)")
                    XCTAssertTrue(serachResponse.totalCount>0)
                  })
        .store(in: &cancellableSet)
    
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 5 seconds")], timeout: 5.0)

    }
    
    func testGetSearchResultInRepoNameEmptyResult() throws {
       gitHubRepository.getSearchResultInRepoName(queryString: "¥¥¥¥¥¥¥¥¥¥¥",
                                         perPage: 60, pageNumber: 1)
            .mapError({ (er) -> ApiResponseError in
                print(er.message)
                return er
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { serachResponse in
                    print("testGetSearchResultInRepoNameEmptyResult Total search results count \(serachResponse.totalCount)")
                    print("testGetSearchResultInRepoNameEmptyResult Current Page search results count \(serachResponse.items.count)")
                    XCTAssertTrue(serachResponse.totalCount == 0)
                  })
        .store(in: &cancellableSet)
    
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 5 seconds seconds")], timeout: 5.0)

    }
    
    func testGetSearchResultInRepoNameInvalidQuery() throws {
       gitHubRepository.getSearchResultInRepoName(queryString: "",
                                         perPage: 60, pageNumber: 1)
            .mapError({ (er) -> ApiResponseError in
                print(er.message)
                XCTAssertTrue(er.message == "Validation Failed")
                return er
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { serachResponse in
                    print("testGetSearchResultInRepoNameInvalidQuery Total search results count \(serachResponse.totalCount)")
                    print("testGetSearchResultInRepoNameInvalidQuery Current Page search results count \(serachResponse.items.count)")
                    XCTAssertTrue(serachResponse.totalCount > 0)
                  })
        .store(in: &cancellableSet)
    
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 5 seconds seconds")], timeout: 5.0)

    }

}
