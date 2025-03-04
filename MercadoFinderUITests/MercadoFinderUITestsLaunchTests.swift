//
//  MercadoFinderUITestsLaunchTests.swift
//  MercadoFinderUITests
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import XCTest

final class MercadoFinderUITestsLaunchTests: XCTestCase {
    @MainActor
    func testInitialUIElements() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["MercadoFinder"].exists)

        let welcomeText = app.staticTexts["Busca productos de MercadoFinder"]
        let sloganText = app.staticTexts["Encuentra lo que necesitas al mejor precio"]

        XCTAssertTrue(welcomeText.exists, "Welcome text should be visible on launch")
        XCTAssertTrue(sloganText.exists, "Slogan text should be visible on launch")
    }
}
