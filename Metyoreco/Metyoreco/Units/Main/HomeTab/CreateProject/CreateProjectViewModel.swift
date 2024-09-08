//
//  CreateProjectViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import Foundation
import UIKit.UIImage

extension CreateProjectView {
    final class CreateProjectViewModel: ObservableObject {
        @Published var image = UIImage()
        @Published var name = ""
        @Published var notes = ""
        @Published var budget = ""
        @Published var counter = 0
        
        @Published var isValidFields = false
        
        func validateFields() {
            let isValidImage = image != UIImage()
            let isValidBudget = (Int(budget) ?? .zero) > .zero
            isValidFields = isValidImage && !name.isEmpty &&
            !notes.isEmpty && isValidBudget && counter > .zero
        }
        
        func creatProject(completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let model = ProjectModel(
                    name: self.name,
                    notes: self.notes,
                    budget: Int(self.budget) ?? .zero,
                    amountOfEquipment: self.counter
                )
                
                // Save item
                DefaultsService.projects.append(model)
                // Save Image
                self.saveImage(image: self.image, to: model.id)
                completion()
            }
        }
        
        private func saveImage(image: UIImage, to pathID: String) {
            guard let data = image.jpegData(compressionQuality: 1) else { return }
            let path = FileManagerService.Keys.image(id: pathID).path
            FileManagerService().saveFile(data: data, forPath: path)
        }
    }
}
