//
//  ErrorView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/13.
//

import SwiftUI

/**
 Display error view
 */
struct ErrorView: View {
    let title: String
    var body : some View {
        Text(LocalizedStringKey(title))
            .padding()
            // more padding
            .padding()
            .background(Color.pink)
            .clipShape(RoundedRectangle(cornerRadius: SearchItemCellConstants.cellRoundedValue))
            .opacity(0.5)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error view")
    }
}
