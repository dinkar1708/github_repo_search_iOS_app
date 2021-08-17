//
//  Data+Extensions.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import Foundation

// MARK:- Just to print data in readable format
extension Data {
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object),
              let printString = String(data: data, encoding:.utf8) else { return nil }
        return printString
    }
}
