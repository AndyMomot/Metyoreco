//
//  HomeButton.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct HomeButton: View {
    var type: ButtonType
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Asset.longButtonBg.swiftUIImage
                .resizable()
                .scaledToFit()
                .overlay {
                    HStack() {
                        Image(type.rawValue)
                        Spacer()
                        Text(type.title)
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.leading, 70)
                    .padding(.trailing)
                }
        }

    }
}

extension HomeButton {
    enum ButtonType: String {
        case createProject
        case calculatingProfit
        case customers
        
        var title: String {
            switch self {
            case .createProject:
                return "Utwórz projekt"
            case .calculatingProfit:
                return "Obliczanie zysku"
            case .customers:
                return "Klienci"
            }
        }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        VStack {
            HomeButton(type: .createProject) {}
            HomeButton(type: .calculatingProfit) {}
            HomeButton(type: .customers) {}
        }
        .padding(.horizontal)
    }
}
