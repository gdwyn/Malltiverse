//
//  ShoppingSummary.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct ShoppingSummary: View {
    @State private var discountCode = ""

    var body: some View {
        
        VStack(alignment: .leading, spacing: 32) {
            Text("Shopping summary")
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 24) {
                Text("Discount code")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .font(.callout)
                HStack(spacing: 18) {
                    TextField("Enter code", text: $discountCode)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(.gray.opacity(0.2))
                        )
                    
                    PrimaryButton(title: "Apply") {}
                        .frame(width: 100)
                }
                
                VStack(spacing: 18) {
                    
                    HStack {
                        Text("Sub-total")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("N 58,800")
                            .font(.subheadline)

                    }
                    
                    HStack {
                        Text("Delivery Fee")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("N 0.00")
                            .font(.subheadline)

                    }
                    
                    HStack {
                        Text("Discount Amount")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("N 0.00")
                            .font(.subheadline)

                    }
                    
                    Text("- - - - - - - - - - - - - - - - - - - - - - - - -")
                        .fontWeight(.light)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Text("Total amount")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("N 58,800")
                            .font(.subheadline)

                    }
                    
                    
                    
                }

            }

        }
        .padding(24)
        .background(.gray.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    ShoppingSummary()
}
