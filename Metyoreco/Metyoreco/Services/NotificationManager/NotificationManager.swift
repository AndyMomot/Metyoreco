//
//  NotificationManager.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation
import UserNotifications
import UIKit.UIApplication

final class NotificationManager {
    static let shared = NotificationManager()

    // Функция для запроса разрешений
    func requestPermission(completion: @escaping (Result<Bool, Error>) -> Void) {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                completion(.failure(error))
            }

            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
            completion(.success(granted))
        }
    }
    
    func checkPermission(completion: @escaping (UNAuthorizationStatus) -> Void) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
}
