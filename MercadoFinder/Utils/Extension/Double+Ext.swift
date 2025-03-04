//
//  DoubleExtension.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import Foundation

extension Double {
    func toFormattedPrice(currency: String = "ARS") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSNumber(value: self)) ?? "$ --"
    }
}
