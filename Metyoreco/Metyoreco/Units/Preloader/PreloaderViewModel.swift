//
//  PreloaderViewModel.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import Foundation

extension PreloaderView {
    final class PreloaderViewModel: ObservableObject {
        @Published var progress = 0.01
        @Published var timer = Timer.publish(
            every: 0.01,
            on: .main,
            in: .common
        )
            .autoconnect()
        
        func updateProgress() {
            let newValue = progress + 0.005
            progress = min(max(newValue, 0), 1)
        }
    }
}
