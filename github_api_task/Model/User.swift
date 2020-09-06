//
//  User.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

struct User: Codable {
    var login: String
    var name: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case email
    }
    
    init() {
        login = ""
        name = ""
        email = ""
    }
}
