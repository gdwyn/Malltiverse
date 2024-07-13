//
//  HeadPhoneCard.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct HeadPhoneCard: View {
    var body: some View {
        ZStack {
            Image("headphone")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
            VStack(alignment: .leading) {
                Text("""
                    Premium Sound,
                    Premium Savings
                    """)
                .font(.title3)
                .fontWeight(.semibold)
                Text("Limited offer, hope on and get yours now")
                    .font(.subheadline)
            }
            .foregroundStyle(.white)
            .padding(.trailing, 24)
            
        } //headphone banner
        .padding(.bottom, 40)
    }
}


#Preview {
    HeadPhoneCard()
}
