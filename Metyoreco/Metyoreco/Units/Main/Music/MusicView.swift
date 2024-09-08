//
//  MusicView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct MusicView: View {
    @StateObject private var viewModel = MusicViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.projects) { project in
                        Text(project.name)
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 15))
                    }
                }
            }
        }
        .onAppear {
            viewModel.getProjects()
        }
    }
}

#Preview {
    MusicView()
}
