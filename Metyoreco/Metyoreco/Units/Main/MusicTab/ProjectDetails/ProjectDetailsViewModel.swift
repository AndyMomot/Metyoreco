//
//  ProjectDetailsViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 10.09.2024.
//

import Foundation

extension ProjectDetailsView {
    final class ProjectDetailsViewModel: ObservableObject {
        @Published var project: ProjectModel?
        @Published var showAddInstrument = false
        
        func handleAddInstrumentView(action: AddInstrumentView.ViewAction) {
            switch action {
            case .cancel:
                showAddInstrument = false
            case .save:
                showAddInstrument = false
                updateProject()
            }
        }
        
        func updateProject() {
            DispatchQueue.main.async { [weak self] in
                guard let self, let project else { return }
                let id = project.id
                self.project = DefaultsService.projects.first(where: {$0.id == id})
            }
        }
    }
}
