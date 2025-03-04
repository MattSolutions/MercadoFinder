//
//  MercadoFinderTests.swift
//  MercadoFinderTests
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import XCTest
@testable import MercadoFinder

final class ProductModelTests: XCTestCase {

    func testProductCondition() {
        let newProduct = Product(id: "123", title: "iPhone", price: 100000, condition: "new")
        XCTAssertEqual(newProduct.conditionString(), AppText.Product.new)

        let usedProduct = Product(id: "456", title: "iPad", price: 50000, condition: "used")
        XCTAssertEqual(usedProduct.conditionString(), AppText.Product.used)

        let nilConditionProduct = Product(id: "789", title: "MacBook", price: 200000, condition: nil)
        XCTAssertNil(nilConditionProduct.conditionString())
    }

    func testFreeShipping() {
        let freeShippingProduct = Product(
            id: "123",
            title: "iPhone",
            price: 100000,
            shipping: Shipping(freeShipping: true)
        )
        XCTAssertEqual(freeShippingProduct.freeShippingText(), AppText.Product.freeShipping)

        let noFreeShippingProduct = Product(
            id: "456",
            title: "iPad",
            price: 50000,
            shipping: Shipping(freeShipping: false)
        )
        XCTAssertNil(noFreeShippingProduct.freeShippingText())
    }

    func testPriceFormatting() {
        let price = 19470000.0
        let formatted = price.toFormattedPrice()

        XCTAssertTrue(formatted.contains("19.470.000"))
    }
}
