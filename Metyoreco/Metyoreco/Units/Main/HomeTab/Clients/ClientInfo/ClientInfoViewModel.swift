//
//  ClientInfoViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import Foundation

extension ClientInfoView {
    final class ClientInfoViewModel: ObservableObject {
        @Published var showEditClient = false
        
        func updateClient(for id: String) -> ClientModel? {
            return DefaultsService.clients.first(where: {$0.id == id})
        }
        
        func deleteClient(for id: String, completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if let index = DefaultsService.clients.firstIndex(where: {$0.id == id}) {
                    DefaultsService.clients.remove(at: index)
                    completion()
                }
            }
        }
    }
}
