//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            Text("1")
                .tag(TabBarSelectionView.home.rawValue)
            
            Text("2")
                .tag(TabBarSelectionView.music.rawValue)
            
            Text("3")
                .tag(TabBarSelectionView.settings.rawValue)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            VStack {
                Spacer()
                TabBarCustomView(selectedItem: $viewModel.selection)
                    .padding(.horizontal, 26)
                    .offset(y: 10)
            }
        }
    }
}

#Preview {
    TabBar()
}
