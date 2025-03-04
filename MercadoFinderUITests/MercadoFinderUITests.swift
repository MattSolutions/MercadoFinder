//
//  MercadoFinderUITests.swift
//  MercadoFinderUITests
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import XCTest

final class MercadoFinderUITests: XCTestCase {
    @MainActor
    func testSearchBarExists() throws {
        let app = XCUIApplication()
        app.launch()

        let searchBar = app.textFields["Buscar productos..."]
        XCTAssertTrue(searchBar.exists, "Search bar should exist")

        searchBar.tap()
        searchBar.typeText("iPhone")

        XCTAssertEqual(searchBar.value as? String, "iPhone", "Search field should contain typed text")
    }
}
