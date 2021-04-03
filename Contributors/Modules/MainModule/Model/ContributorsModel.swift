//
//  ContributorsModel.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation



struct Contributors: Codable {
    
    var login: String?
    var id: Int?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        id = try container.decode(Int.self, forKey: .id)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}
