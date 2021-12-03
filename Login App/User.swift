//
//  User.swift
//  Login App
//
//  Created by Johnny Peterson on 12/2/21.
//

import Foundation

// MARK: - User
public struct User: Decodable {
    public var userID, displayName, token: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayName = "display_name"
        case token
    }
}
