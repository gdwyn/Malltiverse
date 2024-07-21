//
//  HomeView.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    @State private var errorMessage = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack(spacing: 20) {
                    CustomAppBar(title: "Product List")
                        .padding(.horizontal, 24)
                    
                    if vm.isLoading {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else if let errorMessage = vm.errorMessage {
                        VStack(alignment: .center) {
                            Spacer()
                            Text("⚠️")
                                .font(.title)
                            Text(errorMessage)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            
                            Button("Retry") {
                                Task {
                                    await vm.loadProducts()
                                }
                            }
                            .padding()
                            Spacer()
                            Spacer()
                            
                        }
                    } else {
                            ScrollView(showsIndicators: false) {
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack{
                                        ForEach(0..<3, id: \.self) { card in
                                            vm.featuredImages[card]
                                                .resizable()
                                                .scaledToFit()
                                                .padding(.horizontal, 8)
                                                .containerRelativeFrame(.horizontal, count: 1, spacing: 24)
                                                .scrollTransition { content, phase in
                                                    content
                                                        .opacity(phase.isIdentity ? 1 : 0)
                                                        .scaleEffect(phase.isIdentity ? 1 : 0)
                                                }
                                        }
                                    }
                                    .scrollTargetLayout()
                                }
                                .contentMargins(14, for: .scrollContent)
                                .scrollTargetBehavior(.viewAligned)
                                    
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Tech gadgets")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 24)
                                        .padding(.top, 14)

                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                
                                            LazyHStack(spacing: 24) {
                                                ForEach(vm.filterProducts(forCategory: "tech gagdet")) { item in
                                                    ProductCard(item: item)
                                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 24)
                                                    .scrollTransition { content, phase in
                                                        content
                                                            .opacity(phase.isIdentity ? 1 : 0)
                                                            .scaleEffect(phase.isIdentity ? 1 : 0)
                                                    }
                                                }
                                            }
                                            .scrollTargetLayout()
                                            
                                    }
                                    .contentMargins(14, for: .scrollContent)
                                    .scrollTargetBehavior(.viewAligned)
                                    .padding(.horizontal)
                                    .padding(.bottom, 40)
                                }// tech
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Men’s Fashion")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 24)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                
                                            LazyHStack(spacing: 24) {
                                                ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                                    ProductCard(item: item)
                                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 24)
                                                    .scrollTransition { content, phase in
                                                        content
                                                            .opacity(phase.isIdentity ? 1 : 0)
                                                            .scaleEffect(phase.isIdentity ? 1 : 0)
                                                    }
                                                }
                                            }
                                            .scrollTargetLayout()
                                            
                                    }
                                    .contentMargins(14, for: .scrollContent)
                                    .scrollTargetBehavior(.viewAligned)
                                    .padding(.horizontal)
                                    .padding(.bottom, 40)
                                }// men
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Women’s Fashion")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal, 24)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                
                                            LazyHStack(spacing: 24) {
                                                ForEach(vm.filterProducts(forCategory: "women's fashion")) { item in
                                                    ProductCard(item: item)
                                                    .containerRelativeFrame(.horizontal, count: 2, spacing: 24)
                                                    .scrollTransition { content, phase in
                                                        content
                                                            .opacity(phase.isIdentity ? 1 : 0)
                                                            .scaleEffect(phase.isIdentity ? 1 : 0)
                                                    }
                                                }
                                            }
                                            .scrollTargetLayout()
                                            
                                    }
                                    .contentMargins(14, for: .scrollContent)
                                    .scrollTargetBehavior(.viewAligned)
                                    .padding(.horizontal)
                                    .padding(.bottom, 40)
                                }// women
                                
                            }// scrollview
                        
                        }
                    } //v stack
                
                if vm.showToast {
                    VStack {
                        Text("Added to cart")
                            .font(.subheadline)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .padding(.horizontal, 20)
                            .padding(.top, 32)
                            .scaleEffect(vm.toastScale)
                        Spacer()
                    }
                } //toast
                
            } //z stack
            }
            .task{
                await vm.loadProducts()
            }
            .toolbar(.hidden, for: .tabBar)
        
        }
        
    }

#Preview {
    HomeView()
}

