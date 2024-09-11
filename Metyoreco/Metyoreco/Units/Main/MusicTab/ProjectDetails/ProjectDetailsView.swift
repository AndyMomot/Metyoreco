//
//  ProjectDetailsView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import SwiftUI

struct ProjectDetailsView: View {
    var project: ProjectModel
    @State private var image: Image?
    @StateObject private var viewModel = ProjectDetailsViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 38) {
                HStack {
                    BackButtonView(imageName: Asset.musicTab.name)
                    Spacer(minLength: bounds.width * 0.105)
                    NavigationTitleView(text: viewModel.project?.name ?? "")
                }
                .padding(.trailing)
                
                VStack(spacing: 18) {
                    HStack(spacing: 12) {
                        if let image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: bounds.width * 0.395,
                                       height: bounds.width * 0.395)
                                .clipped()
                                .cornerRadius(20, corners: .allCorners)
                        } else {
                            ZStack {
                                Asset.dashedBg.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(width: bounds.width * 0.395,
                                           height: bounds.width * 0.395)
                                Asset.placeholder.swiftUIImage
                            }
                        }
                        
                        VStack(spacing: 14) {
                            HStack {
                                Spacer()
                                Text("Budżet na zadanie")
                                    .foregroundStyle(.white)
                                    .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(size: 20))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                Spacer()
                            }
                            
                            HStack {
                                Spacer()
                                Text("\(viewModel.project?.budget ?? 0)")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .padding(.vertical, 4)
                                Spacer()
                            }
                            .background(Colors.yellowCustom.swiftUIColor)
                            
                            HStack(spacing: 5) {
                                Text("Ilość sprzętu")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 20))
                                    .minimumScaleFactor(0.7)
                                Spacer()
                                
                                Rectangle()
                                    .foregroundStyle(Colors.silverGray.swiftUIColor)
                                    .frame(width: 1)
                                
                                Spacer()
                                
                                Text("\(viewModel.project?.amountOfEquipment ?? 0)")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(size: 35))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(.white)
                            .cornerRadius(10, corners: .allCorners)
                            Spacer()
                            
                            Text("Uwaga do projektu")
                                .foregroundStyle(.white)
                                .font(Fonts.MontserratAlternates.semiBold.swiftUIFont(size: 18))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: bounds.width * 0.395)
                    
                    HStack {
                        Text(viewModel.project?.notes ?? "")
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 11) {
                        HStack {
                            Button {
                                withAnimation {
                                    viewModel.showAddInstrument.toggle()
                                }
                            } label: {
                                ZStack {
                                    Asset.editButtonBg.swiftUIImage
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 25))
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 11) {
                            HStack {
                                Text("Ilość sprzętu")
                                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
                                    .font(Fonts.MontserratAlternates.extraBold.swiftUIFont(size: 20))
                                Spacer()
                            }
                            
                            ForEach(viewModel.instruments) { instrument in
                                Button {
                                    viewModel.instrumentToEdit = instrument
                                    withAnimation {
                                        viewModel.showEditInstrument.toggle()
                                    }
                                } label: {
                                    InstrumentCell(instrument: instrument) {
                                        viewModel.delete(instrument: instrument)
                                    }
                                }
                            }
                            
                            Spacer(minLength: 100)
                        }
                        .padding()
                    }
                    .scrollIndicators(.never)
                    .background(Colors.silverGray.swiftUIColor)
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                }
            }
            .ignoresSafeArea(edges: .bottom)
            
            if viewModel.showAddInstrument {
                AddInstrumentView(viewState: .add(projectId: project.id)) { action in
                    viewModel.handleAddInstrumentView(action: action)
                }
            }
            if viewModel.showEditInstrument {
                if let instrument = viewModel.instrumentToEdit {
                    AddInstrumentView(viewState: .edit(
                        projectId: project.id,
                        model: instrument)) { action in
                            viewModel.handleAddInstrumentView(action: action)
                        }
                }
            }
            
            if viewModel.showLoading {
                ProgressView()
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.project = self.project
                    viewModel.instruments = self.project.instruments.sorted(by: {$0.date > $1.date})
                    image = getImage(for: project.id)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension ProjectDetailsView {
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
    ProjectDetailsView(project: .init(
        name: "Jesień deszcz",
        notes: "Określ motyw przewodni piosenki. Jaka jest główna idea lub fabuła piosenki? Jakie emocje piosenka powinna wywołać u słuchacza?",
        budget: 1500,
        amountOfEquipment: 2
    ))
}
