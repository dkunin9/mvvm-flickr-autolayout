//
//  SearchGroup.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 20.12.2020.
//

import Foundation

class SearchGroup {
    var searchResults: [SearchResult]?
    var page: Int?
    var perPage: Int?
    
    init(with dictionary: [String: Any]) {
        if let photosDictionary = dictionary["photos"] as? [String: Any], let photosDictionaryArray = photosDictionary["photo"] as? [[String: Any]] {
            if let page = photosDictionary["page"] as? Int {
                self.page = page
            }
            if let perPage = photosDictionary["perpage"] as? Int {
                self.perPage = perPage
            }
            var photos = [Photo]()
            for dictionary in photosDictionaryArray {
                let photo = Photo(with: dictionary)
                photos.append(photo)
            }
            self.searchResults = photos
        }
    }
}
