//
//  CoordinatorsTests.swift
//  mvvm-flickr-autolayoutTests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest
@testable import mvvm_flickr_autolayout

class CoordinatorsTests: XCTestCase {
    
    var window: UIWindow?
    
    func testAppCoordinator() {
        window = UIWindow()
        let coordinator = AppCoordinator(window: window!)
        coordinator.start()
        XCTAssertNotNil(coordinator.window.rootViewController, "Failure: Found nil in rootViewController")
    }
    
}
