//
//  NavigationTitleView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct NavigationTitleView: View {
    var text: String
    var alignment: TextAlignment = .leading
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(fixedSize: 30))
            .multilineTextAlignment(alignment)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        VStack {
            HStack {
                NavigationTitleView(text: "Menu główne")
                    .frame(maxWidth: 130)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
