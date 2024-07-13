//
//  CheckoutSuccess.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import Lottie
import SwiftUI

struct CheckoutSuccess: View {
    @Environment (\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            
            LottieView(animation: .named("confetti"))
                .playbackMode(.playing(.toProgress(1, loopMode: .autoReverse)))
                .padding(.bottom, 200)
            
            VStack {
                
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.gray.opacity(0.5))
                        .font(.title)
                    }
                }
                .padding()
                
                VStack(spacing: 16) {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accent)
                                
                    VStack(spacing: 8) {
                        Text("Payment successful")
                            .font(.title3.weight(.medium))
                        
                        Text("Thanks for your purchase")
                            .font(.headline.weight(.regular))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    
//                    PrimaryButton(title: "Done") {
//                        dismiss()
//                    }
//                    .frame(width: 140)
                    
                    
                }
                .padding(.top, 170)
            }
            
        }
    }
}

#Preview {
    CheckoutSuccess()
}