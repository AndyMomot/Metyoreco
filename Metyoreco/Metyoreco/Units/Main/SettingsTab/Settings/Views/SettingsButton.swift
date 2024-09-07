//
//  SettingsButton.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct SettingsButton: View {
    var viewState: ViewState
    var action: () -> Void
    
    @State var foregroundColor: Color = .white
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 10) {
                Image(viewState.imageName)
                    .renderingMode(.template)
                
                Text(viewState.title)
                    .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 21))
            }
            .foregroundStyle(foregroundColor)
            .padding()
        }

    }
}

private extension SettingsButton {
    func onTap() {
        withAnimation {
            foregroundColor = Colors.yellowCustom.swiftUIColor
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            action()
            withAnimation {
                foregroundColor = .white
            }
        }
    }
}

extension SettingsButton {
    enum ViewState {
        case notifications
        case removeCache
        case updating
        
        var title: String {
            switch self {
            case .notifications:
                return "Ustawienie głośności"
            case .removeCache:
                return "Usuń pamięć podręczną"
            case .updating:
                return "Aktualizacja"
            }
        }
        
        var imageName: String {
            switch self {
            case .notifications:
                return Asset.sounds.name
            case .removeCache:
                return Asset.removeCache.name
            case .updating:
                return Asset.updating.name
            }
        }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
        SettingsButton(viewState: .notifications) {
            
        }
        .padding()
    }
}
