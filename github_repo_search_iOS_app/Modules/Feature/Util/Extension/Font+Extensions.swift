//
//  Font+Extensions.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/16.
//

import SwiftUI

// MARK:-For extension related to font size
extension Font {
    static var smallText: Font {
        return .system(size: 10)
    }
    
    static var defaultText: Font {
        return .system(size: 12)
    }
    
    static var mediumText: Font {
        return .system(size: 14)
    }
    
    static var highText: Font {
        return .system(size: 16)
    }
}
