//
//  ProfileImagePickerView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct ProfileImagePickerView: View {
    @Binding var uiImage: UIImage
    @State private var showImagePicker = false
    
    private var isSelected: Bool {
        uiImage != UIImage()
    }
    
    var body: some View {
        Asset.cellBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .overlay {
                HStack(spacing: 25) {
                    Spacer()
                    
                    if isSelected {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 102,
                                   maxHeight: 102)
                            .clipShape(Circle())
                            
                    } else {
                        ZStack {
                            Asset.dashedBg.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                            Asset.placeholder.swiftUIImage
                        }
                        .padding(.vertical, 9)
                    }
                    
                    Button {
                        withAnimation {
                            showImagePicker.toggle()
                        }
                    } label: {
                        Asset.shortButtonBg.swiftUIImage
                            .overlay {
                                Asset.download.swiftUIImage
                            }
                    }
                    
                    Spacer()
                }
            }
            .frame(maxHeight: 120)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $uiImage)
            }
    }
}

#Preview {
    ProfileImagePickerView(uiImage: .constant(.init()))
        .padding(.horizontal)
}
