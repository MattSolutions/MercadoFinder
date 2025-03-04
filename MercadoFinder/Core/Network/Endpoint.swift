//
//  Endpoint.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

enum APIEndpoints {
    static let scheme = "https"
    static let host = "api.mercadolibre.com"
    
    enum Products {
        static let search = "/sites/MLA/search"
        static func details(id: String) -> String { "/items/\(id)" }
    }
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return APIEndpoints.scheme
    }
    
    var host: String {
        return APIEndpoints.host
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
