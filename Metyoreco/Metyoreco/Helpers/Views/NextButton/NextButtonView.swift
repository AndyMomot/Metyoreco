//
//  NextButtonView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct NextButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Asset.buttonBg.swiftUIImage
                .resizable()
                .scaledToFit()
                .overlay {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                        .padding(.horizontal)
                }
        }

    }
}

#Preview {
    NextButtonView(title: "Save") {}
        .padding(.horizontal)
}
