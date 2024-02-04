//
//  Formatter+Extensions.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/13.
//

import Foundation

// MARK:- Formatter use in app
extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = AppConstants.appDateFormat
        return formatter
    }()
}
