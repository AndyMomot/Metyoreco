//
//  RootContentViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var showPreloader = true
        
        @Published var viewState: ViewState = .onboarding
        
        func getFlow() {
            viewState = DefaultsService.flow
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else { return }
                self.showPreloader = false
            }
        }
        
        func setFlow(_ flow: ViewState) {
            DispatchQueue.main.async { [weak self] in
                DefaultsService.flow = flow
                self?.getFlow()
            }
        }
    }
}

extension RootContentView {
    enum ViewState: String {
        case onboarding
        case main
    }
}
