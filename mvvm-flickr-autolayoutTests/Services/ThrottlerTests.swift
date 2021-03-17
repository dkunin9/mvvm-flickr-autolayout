//
//  ThrottlerTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class ThrottlerTests: XCTestCase {
    
    let backgroundQueue = DispatchQueue.global(qos: .background)
    var pendingWorkItem: DispatchWorkItem = DispatchWorkItem(block: {})
    var lastJobDate: Date = Date.distantPast
    var interval: Double = 3.0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThrottle() throws {
        var time1 = Date().timeIntervalSinceReferenceDate
        let time2 = time1
        let expectation = self.expectation(description: "myexpo")
        throttle(block: {
            time1 = Date().timeIntervalSinceReferenceDate
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotEqual(Int(time1), Int(time2))
        XCTAssertEqual(Int(interval), Int(time1) - Int(time2))
    }
    
    func throttle(block: @escaping () -> ()) {
        pendingWorkItem.cancel()
        pendingWorkItem = DispatchWorkItem() { [weak self] in
            self?.lastJobDate = Date()
            block()
        }
        let delay = Double(Date().timeIntervalSince(lastJobDate).rounded()) < interval ? 0 : interval
        backgroundQueue.asyncAfter(deadline: .now() + delay, execute: pendingWorkItem)
    }

}
