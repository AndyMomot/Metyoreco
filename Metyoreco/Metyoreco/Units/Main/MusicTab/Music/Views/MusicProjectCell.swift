//
//  MusicProjectCell.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import SwiftUI

struct MusicProjectCell: View {
    var model: ProjectModel
    var onEdit: () -> Void
    
    @State private var image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.cellBg.swiftUIImage
                .overlay {
                    HStack(spacing: 9) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(model.name)
                                    .foregroundStyle(.white)
                                    .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(size: 25))
                                .minimumScaleFactor(0.6)
                                Spacer()
                            }
                            
                            Spacer()
                            
                            Text("\(model.budget)")
                                .foregroundStyle(Colors.yellowCustom.swiftUIColor)
                                .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                                .minimumScaleFactor(0.6)
                        }
                        .multilineTextAlignment(.leading)
                        .frame(width: bounds.width * 0.26)
                        
                        if let image {
                            image
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
                                Asset.placeholder.swiftUIImage
                            }
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
                    .padding(13)
                }
        }
        .onAppear {
            DispatchQueue.main.async {
                image = getImage(for: model.id)
//                image = Asset.privacyBg.swiftUIImage
            }
        }
    }
}

private extension MusicProjectCell {
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
        MusicProjectCell(model: .init(
            name: "Jesień deszcz",
            notes: "Określ motyw przewodni piosenki. Jaka jest główna idea lub fabuła piosenki? Jakie emocje piosenka powinna wywołać u słuchacza?",
            budget: 1500,
            amountOfEquipment: 2
        )) {}
            .frame(height: 128)
    }
}
