//
//  SearchResult.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

struct SearchResult: Decodable {
    let query: String
    let paging: Paging
    let results: [Product]
    
    struct Paging: Decodable {
        let total: Int
        let offset: Int
        let limit: Int
    }
}
