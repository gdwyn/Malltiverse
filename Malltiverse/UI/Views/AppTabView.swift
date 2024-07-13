//
//  AppTabView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct AppTabView: View {
    @StateObject var homeViewModel = HomeViewModel()

    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView()
                .environmentObject(homeViewModel)
                .tag(1)
            
            CartView()
                .environmentObject(homeViewModel)
                .tag(2)
            
            CheckoutView()
                .environmentObject(homeViewModel)
                .tag(3)
        }
        .overlay(alignment: .bottom) {
           CustomTabView(tabSelection: $tabSelection)
        }
    }
}

#Preview {
    AppTabView()
}
