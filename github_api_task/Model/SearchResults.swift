//
//  Item.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

struct Item: Codable {
    var name: String?
    var full_name: String?
    var description: String?
    var owner: Owner
    
    init() {
        full_name = ""
        description = nil
        owner = Owner()
    }
    
    enum CodingKeys: CodingKey {
        case name
        case full_name
        case description
        case owner
    }
}

struct Owner: Codable {
    var login: String?
}

struct SearchResult: Codable {
    var total_count: Int?
    var items: [Item]
    
    init() {
        total_count = 0
        items = [Item]()
    }
    
    enum CodingKeys: CodingKey {
        case total_count
        case items
    }
}
