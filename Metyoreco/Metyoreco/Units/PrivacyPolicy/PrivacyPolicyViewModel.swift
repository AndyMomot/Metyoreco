//
//  PrivacyPolicyViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import Foundation

extension PrivacyPolicyView {
    final class PrivacyPolicyViewModel: ObservableObject {
        @Published var isAgreed = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://chainesteryps.info/")
        
        func showMainFlow(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                rootViewModel.setFlow(.main)
            }
        }
    }
}
