//
//  github_repo_search_iOS_appUITests.swift
//  github_repo_search_iOS_appUITests
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import XCTest

// perform some base test case
class github_repo_search_iOS_appUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
