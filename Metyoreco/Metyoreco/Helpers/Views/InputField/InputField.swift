////
////  InputField.swift
////  Tradifundint
////
////  Created by Andrii Momot on 08.07.2024.
////
//
import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 15))
            
            TextField(text: $text) {
                Text("wprowadź informacje")
                    .foregroundStyle(Colors.silverGray.swiftUIColor)
                    .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
            }
            .foregroundStyle(Colors.blackCustom.swiftUIColor)
            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .background(.white)
            .cornerRadius(20, corners: .allCorners)
        }
    }
}

extension InputField {
    enum Style {
        case text
        case date
    }
}

#Preview {
    ZStack {
        Asset.createUserBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        InputField(title: "Imię Nazwisko", text: .constant(""))
            .padding(.horizontal)
    }
}
