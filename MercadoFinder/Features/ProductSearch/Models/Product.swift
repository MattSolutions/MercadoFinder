//
//  Product.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
    let pictures: [Picture]?
    let condition: String?
    let shipping: Shipping?
    let soldQuantity: Int?
    let availableQuantity: Int?
    let description: String?
    
    struct Picture: Decodable {
        let id: String
        let url: String
    }
    
    struct Shipping: Decodable {
        let freeShipping: Bool
        
        enum CodingKeys: String, CodingKey {
            case freeShipping = "free_shipping"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, thumbnail, pictures, condition, shipping
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        // check description docx
        case description
    }
}
