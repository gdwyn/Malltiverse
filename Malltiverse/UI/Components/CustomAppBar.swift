//
//  CustomAppBar.swift
//  Malltiverse
//
//  Created by Godwin IE on 13/07/2024.
//

import SwiftUI

struct CustomAppBar: View {
    @EnvironmentObject var vm: HomeViewModel
    
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
            
            HStack(alignment: .firstTextBaseline, spacing: 18) {
                Spacer()
                NavigationLink{
                    BookmarksView()
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bookmark")
                        BadgeView(count: vm.bookmarks.count)
                            .offset(x: 10, y: -10)
                    }
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
