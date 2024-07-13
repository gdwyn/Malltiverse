//
//  HomeView.swift
//  Tim Store
//
//  Created by Godwin IE on 05/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    let columns = [GridItem(.adaptive(minimum: 200))]
    
    @ObservedObject var vm: HomeViewModel
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 99, height: 31)
                        .scaledToFit()
                    Spacer()
                    Text("Product list")
                    Spacer()

                    Spacer()
                        .frame(width: 99)
                }
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
                        
                        HeadPhoneCard()
                            .padding(.horizontal, 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Tech Gadget")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 24)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0) {
                                 
                                    ForEach(vm.filterProducts(forCategory: "tech gagdet")) { item in
                                        NavigationLink {
                                            DetailView(product: item)
                                        } label: {
                                            ProductCard(item: item) {
                                                //action
                                            }
                                            .padding(.leading, 24)
                                        }
                                    }
                                    
                                    Spacer()
                                        .frame(width: 24)
                                }
                            }
                            .padding(.bottom, 64)
                            
                        }// tech gadget
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Men’s Fashion")
                            .font(.title3)
                            .fontWeight(.semibold)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0) {
                                    ForEach(vm.filterProducts(forCategory: "men's fashion")) { item in
                                        NavigationLink {
                                            DetailView(product: item)
                                        } label: {
                                            ProductCard(item: item) {
                                                //action
                                            }
                                                .padding(.leading, 24)
                                            }
                                        }
                                        
                                        Spacer()
                                            .frame(width: 24)
                                }
                            }
                            .padding(.bottom, 64)
                            
                        }// men's fashion
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Women’s Fashion")
                            .font(.title3)
                            .fontWeight(.semibold)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(vm.filterProducts(forCategory: "women's fashion")) { item in
                                        NavigationLink {
                                            DetailView(product: item)
                                        } label: {
                                            ProductCard(item: item) {
                                                //action
                                            }
                                            .padding(.leading, 24)
                                        }
                                    }
                                    
                                    Spacer()
                                        .frame(width: 24)
                                }
                            }
                            .padding(.bottom, 64)
                            
                        }// women's fashion
                    }
                }
            }
//            .padding(.horizontal, 24)
            .padding(.top)
            .task{
                await vm.loadProducts()
        }
        }
        
    }
    
}

#Preview {
    HomeView(vm: HomeViewModel())
}
