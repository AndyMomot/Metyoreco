//
//  CreateUserHomeButton.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct CreateUserHomeButton: View {
    var action: () -> Void
    
    var body: some View {
        Asset.cellBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .overlay {
                VStack(spacing: 8) {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Text("Zaloguj się")
                            .foregroundStyle(.black)
                            .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 20))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 9)
                            .background(.white)
                            .cornerRadius(21, corners: .allCorners)
                    }
                    
                    Text("Wprowadź dane logowania")
                        .foregroundStyle(Colors.yellowCustom.swiftUIColor)
                        .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                }
                .padding(.top, 38)
                .padding(.bottom, 25)
                .padding(.horizontal)
            }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        VStack {
            CreateUserHomeButton {}
                .padding(.horizontal)
            Spacer()
        }
    }
}
