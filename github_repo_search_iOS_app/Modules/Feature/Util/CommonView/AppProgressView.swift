//
//  AppProgressView.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/15.
//

import SwiftUI

/**
 Show progress view
 */
struct AppProgressView: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            // iOS 14 use native one, looks cool
            ProgressView("common_loading")
        } else {
            // make something for ios 13
            ZStack {
                Circle()
                    .stroke(Color.LightGray, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                Circle()
                    .stroke(Color.LightBlue, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .overlay(
                        Text("common_loading").font(.system(size: 10))
                    )
            }.frame(width: 90)
        }
    }
}

struct AppProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AppProgressView()
    }
}
