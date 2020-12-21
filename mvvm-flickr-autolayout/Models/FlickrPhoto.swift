//
//  Photo.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 19.12.2020.
//

import Foundation
import UIKit

extension FlickrPhoto: SearchResult {}

struct FlickrPhoto {
    var id: String?
    var ownerID: String?
    var title: String?
    var thumbnailURL: URL?
    var fullSizeURL: URL?
    
    init(with dictionary: [String: Any]) {
        if let id = dictionary["id"] as? String {
            self.id = id
        }
        if let ownerID = dictionary["owner"] as? String {
            self.ownerID = ownerID
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let thumbnailURLString = dictionary["url_m"] as? String, let thumbnailURL = URL(string: thumbnailURLString) {
            self.thumbnailURL = thumbnailURL
        }
    }
}
