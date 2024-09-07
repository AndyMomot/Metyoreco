//
//  CreateUserView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct CreateUserView: View {
    var viewState: ViewState
    var onDismiss: () -> Void
    
    @StateObject private var viewModel = CreateUserViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Colors.deepSpaceBlue.swiftUIColor
                .ignoresSafeArea()
            Asset.createUserBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                HStack {
                    NavigationTitleView(text: "Autoryzacja")
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 25) {
                        ProfileImagePickerView(uiImage: $viewModel.image)
                        
                        InputField(title: "Imię Nazwisko", 
                                   text: $viewModel.fullName)
                        InputField(title: "Poczta",
                                   text: $viewModel.email)
                        
                        NextButtonView(title: "Zapisz") {
                            viewModel.saveUser {
                                onDismiss()
                                dismiss.callAsFunction()
                            }
                        }
                        .frame(maxHeight: 60)
                        .padding(.top)
                        .opacity(viewModel.isValidFields ? 1 : 0.5)
                        .disabled(!viewModel.isValidFields)
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
        }
        .onAppear {
            withAnimation {
                viewModel.setView(state: viewState)
            }
        }
        .onChange(of: viewModel.image) { _ in
            withAnimation {
                viewModel.validateFields()
            }
        }
        .onChange(of: viewModel.fullName) { _ in
            withAnimation {
                viewModel.validateFields()
            }
        }
        .onChange(of: viewModel.email) { _ in
            withAnimation {
                viewModel.validateFields()
            }
        }
    }
}

#Preview {
    CreateUserView(viewState: .update(
        .init(fullName: "Ivan Ivanov",
              email: "placeholder@gmail.com"))) {}
    
//    CreateUserView(viewState: .create) {}
}
