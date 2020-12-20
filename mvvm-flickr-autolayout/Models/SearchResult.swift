//
//  SearchResult.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import Foundation

protocol SearchResult {
    var id: String? { get set }
    var title: String? { get set }
    var thumbnailURL: URL? { get set }
}

