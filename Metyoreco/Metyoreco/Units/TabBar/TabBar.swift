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
            HomeView(tabBarSelection: $viewModel.selection)
                .tag(TabBarSelectionView.home.rawValue)
            
            MusicView()
                .tag(TabBarSelectionView.music.rawValue)
            
            SettingsView()
                .tag(TabBarSelectionView.settings.rawValue)
        }
        .edgesIgnoringSafeArea(.bottom)
        .overlay {
            VStack {
                Spacer()
                TabBarCustomView(selectedItem: $viewModel.selection)
                    .padding(.horizontal, 26)
            }
        }
    }
}

#Preview {
    TabBar()
}
