//
//  PrimaryButton.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
            Button {
                action()
            } label: {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .font(.callout)
                    .foregroundColor(.dark)
                    .padding(18)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
        }

    }
    
}

struct SecondaryButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.callout)
                    .foregroundColor(.dark)
                    .padding(12)
                    .background(.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.accent)
                    )
        }
    }
    
}

#Preview {
    PrimaryButton(title: "Add to cart") {}
}
