//
//  SearchItemCell.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import SwiftUI

/**
 Search item cell to show single item ui
 */
struct SearchItemCell: View {
    let name: String
    var body : some View {
        HStack {
            Text(name).lineLimit(1).font(.highText)
            Spacer()
        }
        .padding()
        .background(Color.LightBlue)
        .listRowInsets(.init(top: 2,
                             leading: 2,
                             bottom: 2,
                             trailing: 2))
        .clipShape(RoundedRectangle(cornerRadius: SearchItemCellConstants.cellRoundedValue))
    }
}

struct SearchItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemCell(name: "swift-xcode-playground-support")
    }
}
