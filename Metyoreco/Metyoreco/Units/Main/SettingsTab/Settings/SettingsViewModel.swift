//
//  SettingsViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation

extension SettingsView {
    final class SettingsViewModel: ObservableObject {
        @Published var showNotificationSettings = false
        @Published var showAlert = false
        
        let appURL = URL(string: "https://www.apple.com")
        
        func removeAllData(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                DefaultsService.removeAll()
                FileManagerService().removeAllFiles()
                rootViewModel.setFlow(.onboarding)
            }
        }
    }
}
