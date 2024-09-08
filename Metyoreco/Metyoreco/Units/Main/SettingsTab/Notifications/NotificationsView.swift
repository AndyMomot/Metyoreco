//
//  NotificationsView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject private var viewModel = NotificationsViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 150) {
                HStack(alignment: .top) {
                    NavigationTitleView(text: "Ustawienie głośności")
                    Asset.sounds.swiftUIImage
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
            }
            
            VStack(spacing: 22) {
                Text("Powiadomienia włączone")
                    .foregroundStyle(
                        viewModel.isGranted ? Colors.greenCustom.swiftUIColor : .white
                    )
                    .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 22))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                
                Button {
                    withAnimation {
                        if viewModel.isGranted {
                            viewModel.openNotificationSettings()
                        } else {
                            viewModel.requestNotificationPermission()
                        }
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(Colors.silverGray.swiftUIColor.opacity(0.1))
                        .overlay {
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(.white, lineWidth: 2)
                        }
                        .overlay(content: {
                            HStack {
                                if !viewModel.isGranted {
                                    Spacer()
                                }
                                
                                RoundedRectangle(cornerRadius: 32)
                                    .foregroundStyle(viewModel.isGranted ? Colors.greenCustom.swiftUIColor : Colors.blackCustom.swiftUIColor)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 32)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                    .frame(width: bounds.width * 0.2,
                                           height: bounds.height * 0.052)
                                
                                if viewModel.isGranted {
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, bounds.width * 0.03)
                        })
                        .frame(width: bounds.width * 0.4,
                               height: bounds.height * 0.07)
                }
            }
        }
        .onAppear {
            withAnimation {
                viewModel.checkPermission()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NotificationsView()
}
