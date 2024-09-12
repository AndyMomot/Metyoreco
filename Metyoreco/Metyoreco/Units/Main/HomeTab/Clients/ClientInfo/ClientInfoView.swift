//
//  ClientInfoView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import SwiftUI

struct ClientInfoView: View {
    @State var model: ClientModel
    var onDismiss: () -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ClientInfoViewModel()
    @State private var image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepSpaceBlue.swiftUIColor
                .ignoresSafeArea()
            Asset.createUserBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    NavigationTitleView(text: "Klient")
                    Spacer()
                }
                .padding(.horizontal)
                
                Asset.clientBg.swiftUIImage
                    .resizable()
                    .padding()
                    .overlay {
                        VStack(spacing: 20) {
                            
                            HStack(alignment: .top, spacing: 13) {
                                if let image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: bounds.width * 0.2,
                                               height: bounds.width * 0.2)
                                        .clipped()
                                        .clipShape(Circle())
                                } else {
                                    ZStack {
                                        Asset.dashedBg.swiftUIImage
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: bounds.width * 0.2,
                                                   height: bounds.width * 0.2)
                                        Asset.placeholder.swiftUIImage
                                    }
                                }
                                
                                Text(model.name)
                                    .foregroundStyle(.white)
                                    .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 20))
                                    .padding(.top)
                                
                                Spacer()
                                
                                Text("\(model.budget)")
                                    .foregroundStyle(.black)
                                    .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 15))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                    .background(Colors.yellowCustom.swiftUIColor)
                                    .cornerRadius(4, corners: .allCorners)
                                    .cornerRadius(12, corners: .bottomLeft)
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(height: 2)
                                .padding(.horizontal, 30)
                            
                            Text(model.note)
                                .foregroundStyle(.white)
                                .font(Fonts.MontserratAlternates.regular.swiftUIFont(size: 15))
                                .padding(.horizontal, 30)
                            
                            Spacer()
                            
                            HStack {
                                Button {
                                    viewModel.showEditClient.toggle()
                                } label: {
                                    Asset.editBg.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .overlay {
                                            Asset.edit.swiftUIImage
                                        }
                                        .frame(width: 102)
                                }
                                
                                Spacer()
                                
                                Button {
                                    viewModel.deleteClient(for: model.id) {
                                        onDismiss()
                                        dismiss.callAsFunction()
                                    }
                                } label: {
                                    Asset.editBg.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .overlay {
                                            Image(systemName: "trash")
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 102)
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        }
                        .padding(9)
                    }
                
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.async {
                image = getImage(for: model.id)
                //                    image = Asset.privacyBg.swiftUIImage
            }
        }
        .navigationDestination(isPresented: $viewModel.showEditClient) {
            AddClientView(viewState: .update(model)) {
                DispatchQueue.main.async {
                    withAnimation {
                        if let newModel = viewModel.updateClient(for: model.id) {
                            self.model = newModel
                            onDismiss()
                        }
                    }
                }
            }
        }
    }
}

private extension ClientInfoView {
    func getImage(for imageId: String) -> Image? {
        let path = FileManagerService.Keys.image(id: imageId).path
        guard let imageData = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: imageData)
        else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ClientInfoView(model: .init(
        name: "Alexei K",
        note: "Teraz szukam utalentowanego muzyka lub kompozytora, który mógłby pomóc w akompaniamencie muzycznym i nagraniu. Mam już tekst i melodię, ale potrzebuję wsparcia profesjonalisty, aby uczynić tę piosenkę naprawdę wyjątkową.",
        budget: 1000
    )) {}
}
