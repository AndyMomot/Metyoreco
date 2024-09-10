//
//  MusicViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation

extension MusicView {
    final class MusicViewModel: ObservableObject {
        @Published var projects: [ProjectModel] = []
        
        func getProjects() {
            DispatchQueue.main.async { [weak self] in
                self?.projects = DefaultsService.projects.sorted(by: {$0.date > $1.date})
            }
        }
    }
}
