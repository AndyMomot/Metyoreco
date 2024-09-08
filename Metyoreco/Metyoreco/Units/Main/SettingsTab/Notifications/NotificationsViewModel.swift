//
//  NotificationsViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation
import UIKit.UIApplication

extension NotificationsView {
    final class NotificationsViewModel: ObservableObject {
        @Published var isGranted = false
        
        func checkPermission() {
            NotificationManager.shared.checkPermission { [weak self] status in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    switch status {
                    case .authorized:
                        self.isGranted = true
                    default:
                        isGranted = false
                    }
                }
            }
        }
        
        func requestNotificationPermission() {
            NotificationManager.shared.requestPermission { result in
                switch result {
                case .success(let isGranted):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.checkPermission()
                    }
                    
                    if !isGranted {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            self.openNotificationSettings()
                        }
                    }
                    
                case .failure(let error):
                    print("Ошибка при запросе разрешения на уведомления: \(error)")
                }
            }
        }
        
        func openNotificationSettings() {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
