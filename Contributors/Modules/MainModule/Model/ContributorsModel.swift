//
//  ContributorsModel.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation

/*
 "login":"jbkempf",
 "id":9219282,
 "node_id":"MDQ6VXNlcjkyMTkyODI=",
 "avatar_url":"https://avatars.githubusercontent.com/u/9219282?v=4",
 "gravatar_id":"",
 "url":"https://api.github.com/users/jbkempf",
 "html_url":"https://github.com/jbkempf",
 "followers_url":"https://api.github.com/users/jbkempf/followers",
 "following_url":"https://api.github.com/users/jbkempf/following{/other_user}",
 "gists_url":"https://api.github.com/users/jbkempf/gists{/gist_id}",
 "starred_url":"https://api.github.com/users/jbkempf/starred{/owner}{/repo}",
 "subscriptions_url":"https://api.github.com/users/jbkempf/subscriptions",
 "organizations_url":"https://api.github.com/users/jbkempf/orgs",
 "repos_url":"https://api.github.com/users/jbkempf/repos",
 "events_url":"https://api.github.com/users/jbkempf/events{/privacy}",
 "received_events_url":"https://api.github.com/users/jbkempf/received_events",
 "type":"User",
 "site_admin":false,
 "contributions":7040
 
 
 
 */

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
