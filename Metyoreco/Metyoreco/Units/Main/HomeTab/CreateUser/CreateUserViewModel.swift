//
//  CreateUserViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation
import UIKit.UIImage

extension CreateUserView {
    final class CreateUserViewModel: ObservableObject {
        private var viewState: ViewState = .create
        @Published var image = UIImage()
        @Published var fullName = ""
        @Published var email = ""
        @Published var isValidFields = false
        
        func setView(state: ViewState) {
            viewState = state
            switch state {
            case .create:
                break
            case .update(let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    if let image = self.getImage(for: model.id) {
                        self.image = image
                    }
                    self.fullName = model.fullName
                    self.email = model.email
                    self.validateFields()
                }
            }
        }
        
        func validateFields() {
            let isValidImage = image != UIImage()
            isValidFields = isValidImage && !fullName.isEmpty && !email.isEmpty
        }
        
        func saveUser(completion: @escaping () -> Void) {
            switch viewState {
            case .create:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let newUser = UserModel(
                        fullName: self.fullName,
                        email: self.email
                    )
                    
                    DefaultsService.user = newUser
                    self.saveImage(image: self.image, to: newUser.id)
                    completion()
                }
            case .update(var model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    model.fullName = self.fullName
                    model.email = self.email
                    
                    DefaultsService.user = model
                    self.saveImage(image: self.image, to: model.id)
                    completion()
                }
            }
        }
    }
}

private extension CreateUserView.CreateUserViewModel {
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

extension CreateUserView {
    enum ViewState {
        case create
        case update(UserModel)
    }
}
