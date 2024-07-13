//
//  AppTabView.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct AppTabView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(vm: HomeViewModel())
                .tag(1)
            
            Text("Tab 2")
                .tag(2)
            
            Text("Tab 3")
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
