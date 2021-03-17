//
//  WebServiceTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class WebServiceTests: XCTestCase {
    
    var webService = WebService()
    
    var viewModels = [SearchResultViewModel]()
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: Test - API Call to Flickr server
    
    func testNetworkDataRequestSuccess() {
        let queryTerm = "electrolux"
        let expectation = self.expectation(description: "myexp")
        loadSearchResults(with: queryTerm, expectation: expectation)
        self.waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModels)
        XCTAssertEqual(viewModels.count, 20)
    }
    
    //MARK: Fetch data from Flickr and and append to ViewModel
    
    /*
     see original method in extension for SearchListViewModel
     */
    func loadSearchResults(with query: String, enableThrottling: Bool = false, clearResults: Bool = false, expectation: XCTestExpectation) {
        let currentPage = 0
        let nextPage = currentPage + 1
        webService.loadSearchResultsServer(searchTerm: query, page: nextPage) { [weak self] error, searchGroup in
            guard error == nil else {
                print("error == nil")
                return
            }
            if let searchGroup = searchGroup as? SearchGroup, let searchResults = searchGroup.searchResults {
                var viewModels = [SearchResultViewModel]()
                for searchResult in searchResults {
                    let viewModel = SearchResultViewModel(searchResult: searchResult)
                    viewModels.append(viewModel)
                }
                self?.viewModels = viewModels
                expectation.fulfill()
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

