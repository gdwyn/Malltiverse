//
//  BadgeView.swift
//  Malltiverse
//
//  Created by Godwin IE on 21/07/2024.
//

import SwiftUI

struct BadgeView: View {
    var count: Int
    
    var body: some View {
        Text("\(count)")
            .font(.caption2)
            .foregroundColor(.white)
            .padding(5)
            .background(Color.red)
            .clipShape(Circle())
    }
}

#Preview {
    BadgeView(count: 2)
}
