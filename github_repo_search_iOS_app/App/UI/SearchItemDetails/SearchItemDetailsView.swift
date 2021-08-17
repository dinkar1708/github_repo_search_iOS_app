//
//  SearchItemDetailsView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/16.
//

import SwiftUI

/**
 Show the details of search item
 */
struct SearchItemDetailsView: View {
    // note add here more fields on ui to display what data is needed
    var searchItem: SearchItem
    var body: some View {
        VStack {
            Text(searchItem.owner.reposURL).font(.highText).padding()
            VStack(alignment: .leading, spacing: 16) {
                Text(searchItem.name).font(.mediumText)
                Text(searchItem.fullName).font(.defaultText)
                Text(searchItem.owner.type).font(.defaultText)
                Spacer()
            }
        }
    }
}
