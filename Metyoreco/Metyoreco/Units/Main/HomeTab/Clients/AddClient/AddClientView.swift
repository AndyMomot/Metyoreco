//
//  AddClientView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import SwiftUI

struct AddClientView: View {
    var viewState: ViewState
    var onDismiss: () -> Void
    
    @StateObject private var viewModel = AddClientViewModel()
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
                    NavigationTitleView(text: "Tworzenie klienta")
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 25) {
                        ProfileImagePickerView(uiImage: $viewModel.image)
                        
                        InputField(title: "Nazwa klienta",
                                   text: $viewModel.name)
                        
                        DynamicHeightTextField(
                            title: "Życzenia klienta",
                            text: $viewModel.note)
                        .frame(minHeight: 270)
                        
                        InputField(title: "Budżet klienta",
                                   text: $viewModel.budget)
                        
                        NextButtonView(title: "Zapisz") {
                            viewModel.saveClient(viewState: viewState) {
                                DispatchQueue.main.async {
                                    onDismiss()
                                    dismiss.callAsFunction()
                                }
                            }
                        }
                        .frame(maxHeight: 60)
                        .padding(.top)
                        .opacity(viewModel.isValidFields ? 1 : 0.5)
                        .disabled(!viewModel.isValidFields)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 70)
                }
                .scrollIndicators(.never)
            }
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardWhenTappedAround()
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.setView(state: viewState)
                }
            }
        }
        .onChange(of: viewModel.image) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.name) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.note) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.budget) { _ in
            viewModel.validateFields()
        }
    }
}

#Preview {
    AddClientView(viewState: .create) {
        
    }
}
