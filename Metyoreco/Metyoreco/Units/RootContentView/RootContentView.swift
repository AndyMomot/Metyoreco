//
//  RootContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.showPreloader {
                PreloaderView()
            } else {
                switch viewModel.viewState {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .main:
                    TabBar()
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            withAnimation {
                self.viewModel.getFlow()
            }
        }
        .onChange(of: viewModel.viewState) { value in
            print(value.rawValue)
        }
    }
}

#Preview {
    RootContentView()
}
