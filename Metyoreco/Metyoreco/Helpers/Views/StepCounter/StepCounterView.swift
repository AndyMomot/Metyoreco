//
//  StepCounterView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import SwiftUI
struct StepCounterView: View {
    var title: String
    @Binding var counter: Int
    var description: String
    var step: Int = 1
    var allowedNegative = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 15))
            
            HStack(spacing: 18) {
                Spacer()
                
                Button {
                    withAnimation {
                        if !allowedNegative && (counter - step) < .zero {
                            counter = .zero
                        } else {
                            counter -= step
                        }
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(.white)
                        .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 40))
                }
                
                Text("\(counter)")
                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 30))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 66)
                    .background(.white)
                    .cornerRadius(20, corners: .allCorners)
                
                Button {
                    withAnimation {
                        counter += step
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 40))
                }

                
                Spacer()
            }
            
            Text(description)
                .foregroundStyle(Colors.silverGray.swiftUIColor)
                .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
        StepCounterView(title: "ilość sprzętu",
                        counter: .constant(0),
                        description: "Wybór ilości sprzętu do pracy nad projektem")
    }
}
