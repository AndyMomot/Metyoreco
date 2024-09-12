//
//  ClientsListView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import SwiftUI

struct ClientsListView: View {
    @StateObject private var viewModel = ClientsListViewModel()
    
    var body: some View {
        ZStack {
            Colors.deepSpaceBlue.swiftUIColor
                .ignoresSafeArea()
            Asset.createUserBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                HStack {
                    NavigationTitleView(text: "Klienci")
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 17) {
                        Text("W tej sekcji można dodać klienta i zarejestrować jego oczekiwania.")
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                        
                        if !viewModel.clients.isEmpty {
                            ForEach(viewModel.clients) { client in
                                Button {
                                    viewModel.clientToShow = client
                                    viewModel.showClientInfo.toggle()
                                } label: {
                                    ClientCell(model: client)
                                }

                            }
                        }
                        
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(height: 2)
                            .padding(.vertical, 20)
                        
                        Button {
                            viewModel.showAddClient.toggle()
                        } label: {
                            ZStack {
                                Asset.cellBg.swiftUIImage
                                    .resizable()
                                    .frame(height: 47)
                                
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 25))
                            }
                        }

                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation {
                viewModel.getClients()
            }
        }
        .navigationDestination(isPresented: $viewModel.showAddClient) {
            AddClientView(viewState: .create) {
                withAnimation {
                    viewModel.getClients()
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showClientInfo) {
            if let client = viewModel.clientToShow {
                ClientInfoView(model: client) {
                    withAnimation {
                        viewModel.getClients()
                    }
                }
            }
        }
    }
}

#Preview {
    ClientsListView()
}
