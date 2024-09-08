//
//  ProjectModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import Foundation

struct ProjectModel: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    var name, notes: String
    var budget, amountOfEquipment: Int
}
