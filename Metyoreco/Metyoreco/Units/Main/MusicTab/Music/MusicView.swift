//
//  MusicView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct MusicView: View {
    @Binding var tabBarSelection: Int
    @StateObject private var viewModel = MusicViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.homeBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    HStack {
                        NavigationTitleView(text: "Obliczanie budżetu")
                        Spacer(minLength: bounds.width * 0.13)
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 25) {
                            if viewModel.projects.isEmpty {
                                MusicAddUserView {
                                    withAnimation {
                                        tabBarSelection = TabBar.TabBarSelectionView.home.rawValue
                                    }
                                }
                                .frame(height: 74)
                            } else {
                                ForEach(viewModel.projects) { project in
                                    NavigationLink(value: project) {
                                        MusicProjectCell(model: project)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getProjects()
            }
            .navigationDestination(for: ProjectModel.self) { item in
                ProjectDetailsView(project: item)
            }
        }
    }
}

#Preview {
    MusicView(tabBarSelection: .constant(1))
}
