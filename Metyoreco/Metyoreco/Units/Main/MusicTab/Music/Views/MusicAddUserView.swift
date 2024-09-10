//
//  MusicAddUserView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import SwiftUI

struct MusicAddUserView: View {
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 17) {
            Text("Aby utworzyć projekt, należy przejść do sekcji strony głównej")
                .foregroundStyle(.white)
                .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
            
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: 2)
            
            Button {
                action()
            } label: {
                ZStack {
                    Asset.shortButtonBg.swiftUIImage
                        .resizable()
                        .frame(maxWidth: 90, maxHeight: 53)
                    Asset.homeTab.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 35, maxHeight: 35)
                }
                
            }

        }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        MusicAddUserView {}
            .frame(height: 74)
    }
}
