//
//  ThrottlerTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class ThrottlerTests: XCTestCase {
    
    //MARK: Test - Throttle
    
    func testThrottle() throws {
        let interval: Double = 3.0
        let throttler = Throttler(seconds: 3.0)
        var time1 = Date().timeIntervalSinceReferenceDate
        let time2 = time1
        let expectation = self.expectation(description: "myexpo")
        throttler.throttle(block: {
            time1 = Date().timeIntervalSinceReferenceDate
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotEqual(Int(time1), Int(time2))
        XCTAssertEqual(Int(interval), Int(time1) - Int(time2))
    }

}
