//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Asset.onboardingBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Image(item.bgImageName)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Asset.blackLogo.swiftUIImage
                Spacer()
            }
            
            VStack {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 30)
                Spacer()
            }
            
            VStack(spacing: 60) {
                Spacer()
                
                Button {
                    withAnimation {
                        currentPageIndex = item.next.rawValue
                    }
                    
                    if item == .third {
                        viewModel.showPrivacyPolicy.toggle()
                    }
                    
                } label: {
                    Asset.arrowRight.swiftUIImage
                        .padding(.horizontal, 80)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(28, corners: .allCorners)
                }

                
                Text(item.text)
                    .foregroundStyle(.white)
                    .font(Fonts.MontserratAlternates.regular.swiftUIFont(size: 20))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                
                HStack(spacing: 30) {
                    ForEach(0..<3) { index in
                        let isSelected = index == currentPageIndex
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(
                                isSelected ? Colors.yellowCustom.swiftUIColor : Colors.silverGray.swiftUIColor
                            )
                            .frame(height: 8)
                    }
                }
            }
            .padding(.bottom)
        }
        .fullScreenCover(isPresented: $viewModel.showPrivacyPolicy) {
            PrivacyPolicyView()
        }
    }
}

#Preview {
    OnboardingView(item: .first, currentPageIndex: .constant(0))
}
