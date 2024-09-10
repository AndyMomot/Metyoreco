//
//  AddInstrumentView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import SwiftUI

struct AddInstrumentView: View {
    var viewState: ViewState
    var action: (ViewAction) -> Void
    @StateObject private var viewModel = AddInstrumentViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepSpaceBlue.swiftUIColor
                .opacity(0.5)
            
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        HStack {
                            Spacer()
                            
                            Button {
                                action(.cancel)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 30))
                            }
                            .padding(.top)
                        }
                        
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            if viewModel.image != UIImage() {
                                Image(uiImage: viewModel.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: bounds.width * 0.26,
                                           height: bounds.width * 0.26)
                                    .clipped()
                                    .cornerRadius(20, corners: .allCorners)
                            } else {
                                ZStack {
                                    Asset.dashedBg.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .frame(width: bounds.width * 0.26,
                                               height: bounds.width * 0.26)
                                    Asset.placeholder.swiftUIImage
                                }
                            }
                        }
                        .onChange(of: viewModel.image) { _ in
                            viewModel.validateFields()
                        }
                        
                        InputField(title: "Nazwa",
                                   text: $viewModel.name)
                        .onChange(of: viewModel.image) { _ in
                            viewModel.validateFields()
                        }
                        
                        InputField(title: "Budget",
                                   text: $viewModel.budget)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.budget) { _ in
                            viewModel.validateFields()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(Colors.silverGray.swiftUIColor)
                    .cornerRadius(30, corners: .allCorners)
                    
                    NextButtonView(title: "Zapisz") {
                        viewModel.saveInstrument(state: viewState) {
                            action(.save)
                        }
                    }
                    .frame(maxHeight: 60)
                    .padding(.top)
                    .opacity(viewModel.isValidFields ? 1 : 0.5)
                    .disabled(!viewModel.isValidFields)
                }
                .padding(.top)
                .onAppear {
                    viewModel.setView(state: viewState)
                }
                .sheet(isPresented: $viewModel.showImagePicker) {
                    ImagePicker(selectedImage: $viewModel.image)
                }
            }
            .scrollIndicators(.never)
            .padding(.horizontal)
            .hideKeyboardWhenTappedAround()
        }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
        
        AddInstrumentView(viewState: .add(projectId: "")) { _ in }
            .padding(.horizontal)
    }
}
