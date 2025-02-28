//
//  ProductError.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//


import Foundation

enum ProductError: Error {
    case emptySearchQuery
    case invalidProductId
    case productNotFound
    case noResults
}

extension ProductError {
    var userMessage: String {
        switch self {
        case .emptySearchQuery:
            return "Por favor ingresa lo que deseas buscar"
        case .invalidProductId:
            return "No pudimos encontrar el producto solicitado"
        case .productNotFound:
            return "No encontramos el producto que estás buscando"
        case .noResults:
            return "No se encontraron resultados para tu búsqueda"
        }
    }
}

extension ProductError: LocalizedError {
    var errorDescription: String? {
        return userMessage
    }
}
