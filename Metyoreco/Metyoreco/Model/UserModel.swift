//
//  UserModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import Foundation

struct UserModel: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var fullName, email: String
}
