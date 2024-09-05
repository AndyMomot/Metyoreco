//
//  PrivacyPolicyView.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    @StateObject private var viewModel = PrivacyPolicyViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.privacyBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            Color.white.opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .foregroundStyle(Colors.deepSpaceBlue.swiftUIColor)
                    .opacity(0.95)
                    .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                    .frame(height: bounds.height * 0.53)
                    .ignoresSafeArea(edges: .top)
                Spacer()
            }
            
            VStack {
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: bounds.width * 0.3)
                Spacer()
            }
            .padding(.top)
            
            VStack(spacing: 50) {
                Asset.lockPP.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Button {
                    withAnimation {
                        viewModel.showMainFlow(rootViewModel: rootViewModel)
                    }
                } label: {
                    Text("Start")
                        .foregroundStyle(.white)
                        .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 20))
                        .padding(.horizontal, 90)
                        .padding(.vertical, 16)
                        .background(Colors.deepSpaceBlue.swiftUIColor)
                        .cornerRadius(15, corners: .allCorners)
                }
                .opacity(viewModel.isAgreed ? 1 : 0.5)
                .disabled(!viewModel.isAgreed)

                HStack(alignment: .top, spacing: 13) {
                    Button {
                        withAnimation {
                            viewModel.isAgreed.toggle()
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Colors.blackCustom.swiftUIColor, lineWidth: 1)
                            .scaledToFit()
                            .frame(width: 24)
                            .background(.white)
                            .overlay {
                                if viewModel.isAgreed {
                                    RoundedRectangle(cornerRadius: 4)
                                        .scaledToFit()
                                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                        .padding(3)
                                }
                            }
                    }
                    
                    Button {
                        viewModel.showPrivacyPolicy.toggle()
                    } label: {
                        Text("Użytkownik wyraża zgodę na przetwarzanie danych osobowych.")
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                            .font(Fonts.MontserratAlternates.regular.swiftUIFont(size: 12))
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
