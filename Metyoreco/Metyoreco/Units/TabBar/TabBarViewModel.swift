//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.home.rawValue
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case home = 0
        case music
        case settings
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
    }
}
