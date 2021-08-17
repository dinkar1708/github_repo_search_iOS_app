//
//  HomeConstants.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/13.
//

import SwiftUI

/**
 Constants for search item cell
 */
enum SearchItemCellConstants {
    static let cellRoundedValue: CGFloat = 8
}

/**
 Constants for home screen
 */
enum HomeConstants {
    // seconds wait for next api call
    static let searchRepositoryThrottleTime = 1
    // before how many elements remains visible, next page search should start
    static let searchNextPageThreshold = -4
    static let searchPageSize = 80
    static let searchPageDefaultPage = 1
    static let searchInRepositoryName = "name"
}
