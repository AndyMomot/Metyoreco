//
//  ProjectModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 08.09.2024.
//

import Foundation

struct ProjectModel: Codable, Identifiable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    var name, notes: String
    var budget, amountOfEquipment: Int
    var instruments: [InstrumentModel] = []
}

struct InstrumentModel: Codable, Identifiable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    var name: String
    var budget: Int
}
