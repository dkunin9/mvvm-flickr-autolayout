//
//  mvvm_flickr_autolayoutUITests.swift
//  mvvm-flickr-autolayoutUITests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest

class mvvm_flickr_autolayoutUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBarsQuery = app.tabBars
        let secondTabButton = tabBarsQuery.buttons[AccessibilityIdentifiers.SecondTab]
        secondTabButton.tap()
        let firstTabButton = tabBarsQuery.buttons[AccessibilityIdentifiers.FirstTab]
        firstTabButton.tap()
        
        
        let searchField = app.otherElements[AccessibilityIdentifiers.SearchField].searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Electrolux")
        app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        let collectionView = app.collectionViews[AccessibilityIdentifiers.CollectionView]
        collectionView.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        app.navigationBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertEqual(app.alerts.element.label, "Great!")
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
