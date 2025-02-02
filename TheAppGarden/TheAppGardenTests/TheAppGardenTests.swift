//
//  TheAppGardenTests.swift
//  TheAppGardenTests
//
//  Created by Jason Sanchez on 1/31/25.
//

import XCTest
@testable import TheAppGarden

final class TheAppGardenTests: XCTestCase {
    var viewModel: GardenGridViewModel!
    var mockWebService: MockWebService!

    override func setUp() {
        super.setUp()
        mockWebService = MockWebService()
        viewModel = GardenGridViewModel()
    }

    func test_perform_search_with_no_results_should_return_empty_garden_items() async {
        // Arrange
        mockWebService.mockResponse = []

        // Act
        await viewModel.performSearch(query: "non existent plant")

        // Assert
        XCTAssertTrue(viewModel.gardenItems.isEmpty)
    }

}

// Mock WebService
class MockWebService {
    var mockResponse: [Garden] = []

    func load(url: URL) async throws -> [Garden] {
        return mockResponse
    }
}
