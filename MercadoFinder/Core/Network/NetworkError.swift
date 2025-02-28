//
//  NetworkError.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(statusCode: Int)
    case noInternet
    case unknown
}

extension NetworkError {
    var userMessage: String {
        switch self {
        case .invalidURL:
            return "Solicitud inválida. Por favor, intenta nuevamente más tarde."
        case .requestFailed:
            return "No se pudo completar tu solicitud. Por favor, verifica tu conexión a internet."
        case .invalidResponse:
            return "Respuesta inválida del servidor. Por favor, intenta nuevamente."
        case .decodingFailed:
            return "Problema al procesar la respuesta del servidor. Por favor, intenta nuevamente."
        case .serverError(let statusCode):
            return "Error del servidor (Código: \(statusCode)). Por favor, intenta más tarde."
        case .noInternet:
            return "Sin conexión a internet. Por favor, verifica tu configuración de red."
        case .unknown:
            return "Ocurrió un error inesperado. Por favor, intenta nuevamente."
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        return userMessage
    }
    
    var failureReason: String? {
        switch self {
        case .invalidURL:
            return "The URL was improperly formatted or couldn't be constructed"
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "The server response was not valid HTTP"
        case .decodingFailed(let error):
            return "JSON decoding failed: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server returned error status code: \(statusCode)"
        case .noInternet:
            return "Device has no internet connection"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
