//
//  HomeViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 06.09.2024.
//

import Foundation

extension HomeView {
    final class HomeViewModel: ObservableObject {
        @Published var user: UserModel?
        @Published var showCreateUser = false
        @Published var showEditUser = false
        @Published var showCreateProject = false
        @Published var showIncomeExpenditure = false
        @Published var showClients = false
        
        func getUser() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.user = DefaultsService.user
            }
        }
    }
}
