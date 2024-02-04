//
//  NoDataEmptyView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/13.
//

import SwiftUI

/**
 No data empty view
 default i put home repo but we can change it
 */
struct NoDataEmptyView: View {
    let title: String = "home_no_repository_name_found"
    
    var body : some View {
        ErrorView(title: title)
    }
}

struct NoDataEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataEmptyView()
    }
}
