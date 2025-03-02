//
//  Product.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String?
    var title: String
    var price: Double
    var thumbnail: String?
    var pictures: [Picture]?
    var condition: String?
    var shipping: Shipping?
    var soldQuantity: Int?
    var availableQuantity: Int?
    var description: String?
    var initialQuantity: Int?
    var warranty: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail, pictures, condition, shipping
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        case description
        case initialQuantity = "initial_quantity"
        case warranty
    }
    
    func conditionString() -> String {
        return isNew() ? AppText.Product.new : AppText.Product.used
    }
    
    func hasStock() -> Bool {
        return initialQuantity != nil && initialQuantity != 0
    }
    
    func hasWarranty() -> Bool {
        guard let warranty = warranty else { return false }
        return warranty != "Sin garantía" && warranty.count < 40
    }
    
    private func isNew() -> Bool {
        return condition == "new"
    }
    
    func stockString() -> String {
        return hasStock() ? AppText.Product.available : AppText.Product.outOfStock
    }
    
    func freeShippingText() -> String? {
        return shipping?.freeShipping == true ? AppText.Product.freeShipping : nil
    }
}

struct Picture: Codable, Identifiable {
    var id: String?
    var url: String?
}

struct Shipping: Codable {
    var freeShipping: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}
