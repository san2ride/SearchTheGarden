//
//  TheAppGardenUITests.swift
//  TheAppGardenUITests
//
//  Created by Jason Sanchez on 1/31/25.
//

import XCTest

final class TheAppGardenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    func test_should_make_sure_that_search_updates_grid() throws {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("Porcupine")
        
        // Wait for results to load
        let firstResult = app.images.firstMatch
        let exists = firstResult.waitForExistence(timeout: 5)
        
        XCTAssertTrue(exists, "At least one search result should appear")
    }
}
