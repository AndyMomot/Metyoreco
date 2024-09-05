//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var bgImageName: String {
            switch self {
            case .first:
                return Asset.onboardBg1.name
            case .second:
                return Asset.onboardBg2.name
            case .third:
                return Asset.onboardBg2.name
            }
        }
        
        var imageName: String {
            switch self {
            case .first:
                return Asset.guitar.name
            case .second:
                return Asset.drums.name
            case .third:
                return Asset.saxophone.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Śledź koszty stałe, zarządzaj statystykami obecności i kosztów produkcji oraz szacuj marżę zysku. Uzyskaj jasny przegląd wyników finansowych swojej firmy."
            case .second:
                return "Zoptymalizuj swoje operacje i zwiększ efektywność dzięki naszym narzędziom analitycznym. Wykorzystaj precyzyjne raporty, aby lepiej planować przyszłość swojej firmy."
            case .third:
                return "Podejmuj świadome decyzje finansowe i inwestycyjne, aby maksymalizować zyski."
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
    }
}
