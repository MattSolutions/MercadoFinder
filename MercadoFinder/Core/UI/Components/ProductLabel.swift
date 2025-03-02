//
//  ProductLabel.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 28/02/2025.
//

import SwiftUI

struct ProductLabel: View {
    @State private var textWidth: CGFloat = .zero
    
    var backgroundColor: Color
    var cornerRadius: CGFloat
    var fontSize: CGFloat
    var height: CGFloat
    var text: String
    var textColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .foregroundColor(backgroundColor)
                .frame(width: textWidth)
            Text(text)
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundColor(textColor)
                .padding(.horizontal, 10)
                .overlay {
                    GeometryReader { proxy in
                        Color.clear.preference(key: TextWidthKey.self, value: proxy.size.width)
                    }
                }
        }
        .frame(height: height)
        .onPreferenceChange(TextWidthKey.self) { newTextWidth in
            textWidth = newTextWidth
        }
    }
}

struct TextWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
