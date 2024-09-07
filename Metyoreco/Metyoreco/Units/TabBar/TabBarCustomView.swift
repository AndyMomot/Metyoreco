//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.homeTab.name),
        .init(imageName: Asset.musicTab.name),
        .init(imageName: Asset.settingsTab.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        Asset.tabBarBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .overlay {
                HStack {
                    let arrange = (0..<items.count)
                    ForEach(arrange, id: \.self) { index in
                        let item = items[index]
                        let isSelected = index == selectedItem
                        Button {
                            selectedItem = index
                        } label: {
                            Image(item.imageName)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 18)
                                .foregroundStyle(isSelected ? Colors.yellowCustom.swiftUIColor : .white)
                        }

                        if index < arrange.count - 1 {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
    }
}

#Preview {
    TabBarCustomView(selectedItem: .constant(0))
        .padding(.horizontal)
}
