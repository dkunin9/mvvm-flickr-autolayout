//
//  SearchResultTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class SearchResultTests: XCTestCase {
    
    //MARK: Test - SearchResult Model from Data.json
    
    func testSearchResultModel() throws {
        let searchGroup = getSearchGroup()
        let searchResults = searchGroup.searchResults as! [FlickrPhoto]
        XCTAssertNotNil(searchResults, "Failure: Data was not fetched from file Data.json")
        let flickrPhoto = searchResults[0]
        XCTAssertTrue(flickrPhoto.id == "7432654189")
        XCTAssertFalse(flickrPhoto.thumbnailURL == nil)
        XCTAssertEqual(flickrPhoto.title, "Moon")
        XCTAssertEqual(flickrPhoto.ownerID, "user12312")
    }
    
    
    func getSearchGroup() -> SearchGroup {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Data", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        let searchGroup = SearchGroup(with: dictionary!)
        return searchGroup
    }

}
