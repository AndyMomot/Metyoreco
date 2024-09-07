//
//  UserView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct UserView: View {
    var model: UserModel
    var onEdit: () -> Void
    @State private var uiImage = UIImage()
    
    var body: some View {
        Asset.cellBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .overlay {
                HStack(spacing: 16) {
                    if uiImage == UIImage() {
                        ZStack {
                            Asset.dashedBg.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                            Asset.placeholder.swiftUIImage
                        }
                        .padding(.vertical, 9)
                    } else {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 102,
                                   maxHeight: 102)
                            .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(model.fullName)
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 20))
                        Text(model.email)
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.regular.swiftUIFont(size: 15))
                    }
                    
                    Spacer()
                    
                    Button {
                        onEdit()
                    } label: {
                        Asset.shortButtonBg.swiftUIImage
                            .resizable()
                            .overlay {
                                Asset.edit.swiftUIImage
                            }
                            .frame(maxWidth: 44)
                            .padding(.vertical, 9)
                    }
                }
                .padding(.leading)
                .padding(.trailing, 9)
            }
            .frame(maxHeight: 120)
            .onAppear {
                withAnimation {
                    if let uiImage = getImage(for: model.id) {
                        self.uiImage = uiImage
                    }
                }
            }
    }
}

private extension UserView {
    func getImage(for imageId: String) -> UIImage? {
        let path = FileManagerService.Keys.image(id: imageId).path
        guard let imageData = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: imageData)
        else {
            return nil
        }
        return uiImage
    }
}

#Preview {
    UserView(model: .init(
        fullName: "Full name",
        email: "user@gmail.com")
    ) {}
    .padding(.horizontal)
}
