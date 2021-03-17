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
        let expectation = self.expectation(description: "imageservice_expectation")
        let url = "https://live.staticflickr.com/65535/50807403977_f82abcd06a.jpg"
        let imageURL = URL(string: url)
        ImageService.downloadImage(from: imageURL) { image in
            XCTAssertNotNil(image, "Failure: image was not downloaded from the following link: \(url)")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3, handler: nil)
    }
}
