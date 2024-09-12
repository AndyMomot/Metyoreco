//
//  ClientCell.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import SwiftUI

struct ClientCell: View {
    var model: ClientModel
    @State private var image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        Asset.cellBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .overlay {
                HStack(spacing: 13) {
                    if let image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: bounds.width * 0.26,
                                   height: bounds.width * 0.26)
                            .clipped()
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            Asset.dashedBg.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                            Asset.placeholder.swiftUIImage
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            Text(model.name)
                                .foregroundStyle(.white)
                                .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 20))
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
                        
                        Spacer()
                        
                        HStack {
                            Text(model.note)
                                .foregroundStyle(.white)
                                .font(Fonts.MontserratAlternates.regular.swiftUIFont(size: 14))
                            .lineLimit(3)
                            Spacer()
                        }
                    }
                }
                .padding(9)
            }
            .onAppear {
                DispatchQueue.main.async {
                    image = getImage(for: model.id)
//                    image = Asset.privacyBg.swiftUIImage
                }
            }
    }
}

private extension ClientCell {
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
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
        
        ClientCell(model: .init(
            name: "Alexei K",
            note: "Teraz szukam utalentowanego muzyka lub kompozytora, który mógłby pomóc w akompaniamencie muzycznym i nagraniu. Mam już tekst i melodię, ale potrzebuję wsparcia profesjonalisty, aby uczynić tę piosenkę naprawdę wyjątkową.",
            budget: 1000
        ))
        .padding(.horizontal)
    }
}
