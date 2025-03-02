//
//  ErrorStateView.swift
//  MercadoFinder
//
//  Created by MATIAS BATTITI on 01/03/2025.
//

import SwiftUI

struct ErrorStateView: View {
    let error: Error
    let onRetry: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: IconNames.warning)
                .font(.system(size: 40))
                .foregroundColor(.red)
            
            Text(AppText.Common.error)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            if let networkError = error as? NetworkError {
                Text(networkError.userMessage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                Text(error.localizedDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            if let onRetry = onRetry {
                Button(action: onRetry) {
                    HStack(spacing: 8) {
                        Image(systemName: IconNames.retry)
                        Text(AppText.Common.retry)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 50)
    }
}
