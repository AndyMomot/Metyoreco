//
//  HomeView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 06.09.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.homeBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 50) {
                    HStack {
                        NavigationTitleView(text: "Menu główne")
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 38) {
                            if let user = viewModel.user {
                                UserView(model: user) {
                                    viewModel.showEditUser.toggle()
                                }
                            } else {
                                CreateUserHomeButton {
                                    viewModel.showCreateUser.toggle()
                                }
                            }
                            
                            HomeButton(type: .createProject) {
                                
                            }
                            HomeButton(type: .calculatingProfit) {
                                
                            }
                            HomeButton(type: .customers) {
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                }
            }
            .onAppear {
                withAnimation {
                    viewModel.getUser()
                }
            }
            // Destinations
            .navigationDestination(isPresented: $viewModel.showCreateUser) {
                CreateUserView(viewState: .create) {
                    withAnimation {
                        viewModel.getUser()
                    }
                }
                .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $viewModel.showEditUser) {
                if let user = viewModel.user {
                    CreateUserView(viewState: .update(user)) {
                        withAnimation {
                            viewModel.getUser()
                        }
                    }
                    .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
