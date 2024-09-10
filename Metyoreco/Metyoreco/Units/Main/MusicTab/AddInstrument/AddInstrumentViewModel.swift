//
//  AddInstrumentViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import Foundation
import UIKit.UIImage

extension AddInstrumentView {
    final class AddInstrumentViewModel: ObservableObject {
        @Published var image = UIImage()
        @Published var name = ""
        @Published var budget = ""
        @Published var showImagePicker = false
        @Published var isValidFields = false
        
        func validateFields() {
            let isValidBudget = (Int(budget) ?? .zero) > .zero
            isValidFields = image != UIImage() && !name.isEmpty && isValidBudget
        }
        
        func setView(state: ViewState) {
            switch state {
            case .add:
                break
            case .edit(_, let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.image = self.getImage(for: model.id) ?? .init()
                    self.name = model.name
                    self.budget = "\(model.budget)"
                }
            }
        }
        
        func saveInstrument(state: ViewState, completion: @escaping () -> Void) {
            guard isValidFields else { return }
            
            switch state {
            case .add(let projectId):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let instrument = InstrumentModel(
                        name: self.name,
                        budget: Int(self.budget) ?? .zero
                    )
                    
                    if let index = DefaultsService.projects.firstIndex(where: {$0.id == projectId}) {
                        DefaultsService.projects[index].instruments.append(instrument)
                    }
                    
                    self.saveImage(image: self.image, to: instrument.id)
                    completion()
                }
                
            case .edit(let projectId, var model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    model.name = self.name
                    model.budget = Int(self.budget) ?? .zero
                    
                    if let projectIndex = DefaultsService.projects.firstIndex(where: {$0.id == projectId}) {
                        if let instrumentIndex = DefaultsService.projects[projectIndex].instruments.firstIndex(where: {$0.id == model.id}) {
                            DefaultsService.projects[projectIndex].instruments[instrumentIndex] = model
                        }
                    }
                    
                    self.saveImage(image: self.image, to: model.id)
                    completion()
                }
            }
        }
    }
}

private extension AddInstrumentView.AddInstrumentViewModel {
    func getImage(for imageId: String) -> UIImage? {
        let path = FileManagerService.Keys.image(id: imageId).path
        guard let imageData = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: imageData)
        else {
            return nil
        }
        return uiImage
    }
    
    func saveImage(image: UIImage, to pathID: String) {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        let path = FileManagerService.Keys.image(id: pathID).path
        FileManagerService().saveFile(data: data, forPath: path)
    }
}

extension AddInstrumentView {
    enum ViewState {
        case add(projectId: String)
        case edit(projectId: String, model: InstrumentModel)
    }
    
    enum ViewAction {
        case cancel
        case save
    }
}
