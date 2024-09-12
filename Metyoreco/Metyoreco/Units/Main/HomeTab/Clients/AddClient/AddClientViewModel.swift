//
//  AddClientViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import Foundation
import UIKit.UIImage

extension AddClientView {
    final class AddClientViewModel: ObservableObject {
        @Published var image = UIImage()
        @Published var name = ""
        @Published var note = ""
        @Published var budget = ""
        @Published var isValidFields = false
        
        func validateFields() {
            let isValidImage = image != UIImage()
            let isValidBudget = Int(budget) ?? .zero > .zero
            isValidFields = isValidImage && !name.isEmpty &&
                            !note.isEmpty && isValidBudget
        }
        
        func setView(state: ViewState) {
            switch state {
            case .create:
                break
            case .update(let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if let image = self.getImage(for: model.id) {
                        self.image = image
                    }
                    self.name = model.name
                    self.note = model.note
                    self.budget = "\(model.budget)"
                    self.validateFields()
                }
            }
        }
        
        func saveClient(viewState: ViewState, completion: @escaping () -> Void) {
            switch viewState {
            case .create:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let newClient = ClientModel(
                        name: self.name,
                        note: self.note,
                        budget: Int(self.budget) ?? .zero
                    )
                    
                    DefaultsService.clients.append(newClient)
                    self.saveImage(image: self.image, to: newClient.id)
                    completion()
                }
            case .update(var model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    model.name = self.name
                    model.note = self.note
                    model.budget = Int(self.budget) ?? .zero
                    
                    if let index = DefaultsService.clients.firstIndex(where: {$0.id == model.id}) {
                        DefaultsService.clients[index] = model
                    }
                    self.saveImage(image: self.image, to: model.id)
                    completion()
                }
            }
        }
    }
}

private extension AddClientView.AddClientViewModel {
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

extension AddClientView {
    enum ViewState {
        case create
        case update(ClientModel)
    }
}
