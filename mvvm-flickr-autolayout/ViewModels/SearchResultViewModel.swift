//
//  SearchResultViewModel.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import UIKit

struct SearchResultViewModel {
    
    // MARK: - Variables
    
    var title: String?
    var imageURL: URL?
    
    // MARK: - Life Cycle
    
    init(searchResult: SearchResult) {
        self.title = searchResult.title
        self.imageURL = searchResult.thumbnailURL
    }
    
}
