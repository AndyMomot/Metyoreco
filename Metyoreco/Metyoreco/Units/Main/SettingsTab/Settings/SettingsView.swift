//
//  SettingsView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.homeBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 150) {
                    HStack {
                        NavigationTitleView(text: "Ustawienia")
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        SettingsButton(viewState: .notifications) {
                            viewModel.showNotificationSettings.toggle()
                        }
                        
                        SettingsButton(viewState: .removeCache) {
                            withAnimation {
                                viewModel.showAlert.toggle()
                            }
                        }
                        
                        if let url = viewModel.appURL {
                            SettingsButton(viewState: .updating) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .alert("Czy na pewno chcesz usunąć pamięć podręczną?", isPresented: $viewModel.showAlert) {
                Button("usuwać", role: .destructive) {
                    viewModel.removeAllData(rootViewModel: rootViewModel)
                }
                Button("anulować", role: .cancel) { }
            }
            .navigationDestination(isPresented: $viewModel.showNotificationSettings) {
                NotificationsView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    SettingsView()
}
