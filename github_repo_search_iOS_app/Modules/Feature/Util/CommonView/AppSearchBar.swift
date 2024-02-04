//
//  SearchBar.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import SwiftUI

/**
 Reusable search bar for the app
 */
struct AppSearchBar: UIViewRepresentable {
    @Binding var text: String
    @State var isEditing: Bool = false
    let textDidChanged: (String) -> ()
    @Binding var placeholder: String
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        let textDidChanged: (String) -> ()
        
        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
            _text = text
            self.textDidChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            textDidChanged(text)
        }
    }

    func makeCoordinator() -> AppSearchBar.Coordinator {
        return Coordinator(text: $text, onTextChanged: textDidChanged)
    }
    
    func makeUIView(context: UIViewRepresentableContext<AppSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        // cancel text color
        searchBar.tintColor = Color.LightBlue.uiColor()
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            if let imageView = textFieldInsideSearchBar.leftView as? UIImageView {
                imageView.image = imageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                // left icon color
                imageView.tintColor = Color.LightGray.uiColor()
                // text box text color
                textFieldInsideSearchBar.textColor = Color.DarkBlue.uiColor()
                // cursor color
                textFieldInsideSearchBar.tintColor = Color.LightBlue.uiColor()
            }
            if let clearButton = textFieldInsideSearchBar.value(forKey: "_clearButton") as? UIButton {
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(templateImage, for: .normal)
                clearButton.tintColor = Color.LightBlue.uiColor()
            }
        }
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<AppSearchBar>) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
}
