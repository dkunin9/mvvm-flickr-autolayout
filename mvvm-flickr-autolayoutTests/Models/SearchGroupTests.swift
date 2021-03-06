//
//  SearchImagesTests.swift
//  mvvm-flickr-autolayout
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class SearchGroupTests: XCTestCase {
    
    //MARK: Test - SearchGroup Model from Data.json
    
    func testSearchGroupModel() throws {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Data", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        let searchGroup = SearchGroup(with: dictionary!)
        XCTAssertTrue(searchGroup.page == 1)
        XCTAssertTrue(searchGroup.perPage == 20)
        XCTAssertNotNil(searchGroup.searchResults, "Failure: Data was not fetched from Data.json")
    }

}
