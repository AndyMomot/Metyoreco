//
//  ClientsListViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import Foundation

extension ClientsListView {
    final class ClientsListViewModel: ObservableObject {
        @Published var clients: [ClientModel] = []
        @Published var showAddClient = false
        @Published var showClientInfo = false
        @Published var clientToShow: ClientModel?
        
        func getClients() {
            DispatchQueue.main.async { [weak self] in
                self?.clients = DefaultsService.clients
            }
        }
    }
}
