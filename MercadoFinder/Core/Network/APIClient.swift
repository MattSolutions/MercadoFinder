//
//  APIClient.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = makeURL(from: endpoint) else {
            Logger.error("Invalid URL constructed")
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        Logger.info("Making request to: \(url.absoluteString)")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.error("Invalid response type")
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } catch {
                    Logger.error("Failed to decode response: \(error)")
                    throw NetworkError.decodingFailed(error)
                }
            case 401, 403:
                Logger.error("Authentication error: \(httpResponse.statusCode)")
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            case 404:
                Logger.error("Resource not found: \(httpResponse.statusCode)")
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            default:
                Logger.error("Server error: \(httpResponse.statusCode)")
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
        } catch let urlError as URLError {
            Logger.error("URL session error: \(urlError)")
            throw NetworkError.requestFailed(urlError)
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            Logger.error("Unknown error: \(error)")
            throw NetworkError.unknown
        }
    }
    
    private func makeURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        return components.url
    }
}
