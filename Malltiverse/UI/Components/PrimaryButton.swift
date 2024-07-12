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
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(.accent)
                .cornerRadius(100)
        }
    }
    
}

#Preview {
    PrimaryButton(title: "Add to cart") {}
}
