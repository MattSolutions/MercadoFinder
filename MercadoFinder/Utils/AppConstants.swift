//
//  AppConstants.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation
import SwiftUI

// MARK: - Text Constants
enum AppText {
    enum Common {
        static let accept = "Aceptar"
        static let retry = "Intentar nuevamente"
        static let loading = "Cargando..."
        static let error = "Error"
        static let appName = "MercadoFinder"
    }

    enum Product {
        static let new = "Nuevo"
        static let used = "Usado"
        static let freeShipping = "Envío Gratis"
        static let available = "Disponible"
        static let outOfStock = "Sin stock"
        static let buy = "Comprar en Mercado Libre"
    }

    enum Search {
        static let placeholder = "Buscar productos..."
        static let welcome = "Busca productos de MercadoFinder"
        static let slogan = "Encuentra lo que necesitas al mejor precio"
    }
}

// MARK: - Icon Names
enum IconNames {
    static let clear = "xmark"
    static let emptyImage = "photo"
    static let failImage = "exclamationmark.circle"
    static let warning = "exclamationmark.triangle"
    static let retry = "arrow.clockwise"
    static let search = "magnifyingglass"
    static let shield = "checkmark.shield"
    static let backArrow = "arrow.left"
}

// MARK: - String Extensions
extension String {
    func toLocalizedStringKey() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
