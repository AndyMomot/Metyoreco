//
//  BackButtonView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import SwiftUI

struct BackButtonView: View {
    var imageName: String
    var onDismiss: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            onDismiss?()
            dismiss.callAsFunction()
        } label: {
            HStack(spacing: -30) {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.white)
                    .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(size: 50))
                
                Circle()
                    .foregroundStyle(.white)
                    .frame(maxWidth: 50)
                    .overlay {
                        Image(imageName)
                            .renderingMode(.template)
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .padding(14)
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
        BackButtonView(imageName: Asset.homeTab.name)
    }
}
