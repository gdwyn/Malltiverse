//
//  CheckoutView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CheckoutView: View {
    @State private var cardNumber = ""
    @State private var expiry = ""
    @State private var cvv = ""
    
    @State private var showSheet = false
    @State private var isPaid = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var vm: HomeViewModel

    var body: some View {
        NavigationStack{
            VStack(spacing: 24) {
                //CustomAppBar(title: "Payment")
                
                Image("Card")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Card number")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .font(.callout)
                    
                    TextField("0000 0000 0000 0000", text: $cardNumber)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(.gray.opacity(0.2))
                        )
                } //card no
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Expiry date")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .font(.callout)
                        
                        TextField("MM/YY", text: $expiry)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.gray.opacity(0.2))
                            )
                    }  // expiry
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("CVV")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .font(.callout)
                        
                        TextField("123", text: $cvv)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.gray.opacity(0.2))
                            )
                    } // cvv
                }
                
                PrimaryButton(title: "Make payment") {
                    showSheet = true
                    vm.history.append(contentsOf: vm.cartItems)
                    vm.cartItems.removeAll()
                }
            
                Spacer()
            }
            .padding(24)
            .sheet(isPresented: $showSheet) {
                CheckoutSuccess(isPaid: $isPaid) {
                    presentationMode.wrappedValue.dismiss()

                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Payment")
                        }
                    }
                }
                
            }
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                    withAnimation(.smooth(duration: 0.5)) {
                        vm.tabOpacity = false
                    }
                }
                
            }
            
            .onDisappear {
                withAnimation(.smooth(duration: 0.5)) {
                    vm.tabOpacity = true
                }
            }
            

        }
    }
}

#Preview {
    CheckoutView()
}
