//
//  CustomAppBar.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CustomAppBar: View {
    var title: String
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 99, height: 31)
                .scaledToFill()
            Spacer()
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            
            HStack(spacing: 16) {
                Spacer()
                NavigationLink{
                    BookmarksView()
                } label: {
                        Image(systemName: "bookmark")
                }
                
                NavigationLink{
                    HistoryView()
                } label: {
                        Image(systemName: "clock")
                }
            
            }
            .foregroundStyle(.gray)
            .frame(width: 99)
        }
    }
}

#Preview {
    CustomAppBar(title: "Title")
}
