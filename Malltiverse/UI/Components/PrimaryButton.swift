//
//  PrimaryButton.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var isFilled: Bool
    var action: () -> Void
    
    var body: some View {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.callout)
                    .foregroundColor(isFilled ? .white : .black)
                .padding(12)
                .background(isFilled ? .accent : .clear)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(isFilled ? .clear : .accent, lineWidth: 1)
                )
        }
    }
    
}

#Preview {
    PrimaryButton(title: "Add to cart", isFilled: true) {}
}
