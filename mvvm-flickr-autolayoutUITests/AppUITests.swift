//
//  mvvm_flickr_autolayoutUITests.swift
//  mvvm-flickr-autolayoutUITests
//
//  Created by Daniel on 17.03.2021.
//

import XCTest

class AppTests: XCTestCase {

    func testFindImageAndSave() throws {
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
        app.otherElements["PopoverDismissRegion"].tap()
        
        let collectionView = app.collectionViews[AccessibilityIdentifiers.CollectionView]
        collectionView.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        app.navigationBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertEqual(app.alerts.element.label, "Great!")
        
        app.navigationBars.buttons.element(boundBy: 0).tap()

    }
}
