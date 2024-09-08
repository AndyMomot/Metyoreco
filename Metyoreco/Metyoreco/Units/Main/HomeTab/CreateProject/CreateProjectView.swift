//
//  CreateProjectView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import SwiftUI

struct CreateProjectView: View {
    @StateObject private var viewModel = CreateProjectViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var onDismiss: () -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    BackButtonView(imageName: Asset.homeTab.name)
                    Spacer(minLength: bounds.width * 0.105)
                    NavigationTitleView(text: "Utwórz projekt")
                }
                .padding(.trailing)
                
                ScrollView {
                    VStack(spacing: 18) {
                        ProfileImagePickerView(uiImage: $viewModel.image)
                            .padding(.top, 20)
                        
                        InputField(title: "Nazwa projektu",
                                   text: $viewModel.name)
                        DynamicHeightTextField(
                            title: "Uwaga do projektu",
                            text: $viewModel.notes)
                        .frame(minHeight: 117)
                        InputField(title: "Budget per job",
                                   text: $viewModel.budget)
                        
                        StepCounterView(
                            title: "ilość sprzętu",
                            counter: $viewModel.counter,
                            description: "Wybór ilości sprzętu do pracy nad projektem")
                        
                        NextButtonView(title: "Zapisz") {
                            viewModel.creatProject {
                                onDismiss()
                                dismiss.callAsFunction()
                            }
                        }
                        .frame(maxHeight: 60)
                        .padding(.top)
                        .opacity(viewModel.isValidFields ? 1 : 0.5)
                        .disabled(!viewModel.isValidFields)
                    }
                }
                .scrollIndicators(.never)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .hideKeyboardWhenTappedAround()
        .onChange(of: viewModel.image) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.name) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.notes) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.budget) { _ in
            viewModel.validateFields()
        }
        .onChange(of: viewModel.counter) { _ in
            viewModel.validateFields()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateProjectView {}
}
