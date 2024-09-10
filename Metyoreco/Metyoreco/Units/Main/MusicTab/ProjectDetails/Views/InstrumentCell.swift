//
//  InstrumentCell.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import SwiftUI

struct InstrumentCell: View {
    var instrument: InstrumentModel
    var onDelete: () -> Void
    
    @State private var image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 20) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: bounds.width * 0.232,
                           height: bounds.width * 0.232)
                    .clipped()
                    .cornerRadius(20, corners: .allCorners)
            } else {
                ZStack {
                    Asset.dashedBg.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: bounds.width * 0.232,
                               height: bounds.width * 0.232)
                    Asset.placeholder.swiftUIImage
                }
            }
            
            VStack {
                HStack {
                    Text(instrument.name)
                        .foregroundStyle(Colors.blackCustom.swiftUIColor)
                        .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 18))
                    Spacer()
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("\(instrument.budget)")
                        .foregroundStyle(.white)
                        .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 15))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Colors.graphite.swiftUIColor)
                        .cornerRadius(17, corners: [.topLeft, .bottomRight])
                }
            }
        }
        .padding(6)
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Colors.graphite.swiftUIColor, lineWidth: 2)
                .frame(maxHeight: 106)
        }
        .onAppear {
            DispatchQueue.main.async {
                image = getImage(for: instrument.id)
            }
        }
    }
}

private extension InstrumentCell {
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
        Colors.silverGray.swiftUIColor
        
        InstrumentCell(instrument: .init(
            name: "Nazwa sprzętu",
            budget: 500
        )) {}
            .frame(height: 106)
            .padding(.horizontal)
        
    }
}
