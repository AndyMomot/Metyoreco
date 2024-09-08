//
//  DynamicHeightTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct DynamicHeightTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 15))
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                
                TextEditor(text: $text)
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                    .padding()
                
                
                if text.isEmpty {
                    Text("wprowadź informacje")
                        .foregroundStyle(Colors.silverGray.swiftUIColor)
                        .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
            }
            .cornerRadius(20, corners: .allCorners)
        }
    }
}

#Preview {
    ZStack {
        Colors.blackCustom.swiftUIColor
        DynamicHeightTextField(
            title: "Uwaga do projektu",
            text: .constant(""))
        .frame(maxHeight: 117)
        .padding()
    }
}
