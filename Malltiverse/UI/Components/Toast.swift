//
//  Toast.swift
//  Tim Store
//
//  Created by Godwin IE on 06/07/2024.
//

import SwiftUI

struct Toast: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.subheadline)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal, 20)
    }
}

#Preview {
    Toast(message: "")
}
