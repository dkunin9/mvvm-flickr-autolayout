//
//  ImageServiceTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class ImageServiceTests: XCTestCase {
    
    //MARK: Test - Download&Cache image
    
    func testImageService() throws {
        let expectation = self.expectation(description: "myexp")
        let imageURL = URL(string: "https://live.staticflickr.com/65535/50807403977_f82abcd06a.jpg")
        ImageService.downloadImage(from: imageURL) { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3, handler: nil)
    }
}
