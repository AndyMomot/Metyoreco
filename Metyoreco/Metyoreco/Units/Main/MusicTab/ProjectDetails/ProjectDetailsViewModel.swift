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
        @Published var instruments: [InstrumentModel] = []
        @Published var showAddInstrument = false
        @Published var showEditInstrument = false
        @Published var showLoading = false
        var instrumentToEdit: InstrumentModel?
        
        func handleAddInstrumentView(action: AddInstrumentView.ViewAction) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.showAddInstrument = false
                self.showEditInstrument = false
                self.showLoading = false
            }
                
            switch action {
            case .cancel:
                break
            case .save:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.updateProject()
                }
            }
        }
        
        func updateProject() {
            self.instruments.removeAll()
            DispatchQueue.main.async { [weak self] in
                guard let self, let project else { return }
                let id = project.id
                self.project = DefaultsService.projects.first(where: {$0.id == id})
                self.instruments = self.project?.instruments.sorted(by: {$0.date > $1.date}) ?? []
            }
        }
        
        func delete(instrument: InstrumentModel) {
            DispatchQueue.main.async { [weak self] in
                guard let self, let project else { return }
                
                if let projectIndex = DefaultsService.projects.firstIndex(where: {
                    $0.id == project.id
                }) {
                    if let instrumentIndex = project.instruments.firstIndex(where: {
                        $0.id == instrument.id
                    }) {
                        DefaultsService.projects[projectIndex].instruments.remove(at: instrumentIndex)
                        self.updateProject()
                    }
                }
            }
        }
    }
}
