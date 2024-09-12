//
//  ClientModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 12.09.2024.
//

import Foundation

struct ClientModel: Codable, Identifiable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    var name, note: String
    var budget: Int
}
