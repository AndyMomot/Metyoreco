//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    static var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
    
    static var user: UserModel? {
        get {
            if let data = standard.object(forKey: Keys.user.rawValue) as? Data {
                let user = try? JSONDecoder().decode(UserModel.self, from: data)
                return user
            }
            return nil
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.user.rawValue)
            }
        }
    }
    
    static var projects: [ProjectModel] {
        get {
            if let data = standard.object(forKey: Keys.projects.rawValue) as? Data {
                let items = try? JSONDecoder().decode([ProjectModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.projects.rawValue)
            }
        }
    }
    
    static var incomeExpenditure: IncomeExpenditureModel? {
        get {
            if let data = standard.object(forKey: Keys.incomeExpenditure.rawValue) as? Data {
                let model = try? JSONDecoder().decode(IncomeExpenditureModel.self, from: data)
                return model
            }
            return nil
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.incomeExpenditure.rawValue)
            }
        }
    }
    
    static var clients: [ClientModel] {
        get {
            if let data = standard.object(forKey: Keys.clients.rawValue) as? Data {
                let items = try? JSONDecoder().decode([ClientModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.clients.rawValue)
            }
        }
    }
}

extension DefaultsService {
    static func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case user
        case projects
        case incomeExpenditure
        case clients
    }
}
