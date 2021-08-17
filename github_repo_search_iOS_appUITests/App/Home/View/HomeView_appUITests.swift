//
//  HomeView_appUITests.swift
//  github_repo_search_iOS_appUITests
//
//  Created by Dinakar Maurya on 2021/08/14.
//

import XCTest

// home view test cases
class HomeView_appUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testHomeHeadView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let firstElement = "Start typing to see the data from api..."
        XCTAssertTrue(app.staticTexts[firstElement].waitForExistence(timeout: 10))
        
         // test the help text exists
        XCTAssert(app.staticTexts[firstElement].exists)

        // test title bar
        let homeViewNavBarTitle = "Search Github Repository"
        XCTAssert(app.navigationBars.matching(identifier: homeViewNavBarTitle).firstMatch.exists)
    }

    func testHomeViewBodySearchField() throws {
    }
    
    func testHomeViewBodySearchResult() throws {
    }
}
