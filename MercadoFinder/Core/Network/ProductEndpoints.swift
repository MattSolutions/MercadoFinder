//
//  ProductEndpoints.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

enum ProductEndpoints {
    case searchProducts(productName: String)
    case productDetail(productId: String)
}

extension ProductEndpoints: Endpoint {
    var path: String {
        switch self {
        case .productDetail(let productId):
            return APIEndpoints.Products.details(id: productId)
        case .searchProducts:
            return APIEndpoints.Products.search
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .searchProducts, .productDetail:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchProducts(let productName):
            return [URLQueryItem(name: "q", value: productName)]
        case .productDetail:
            return nil
        }
    }
}
