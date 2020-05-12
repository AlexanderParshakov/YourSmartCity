//
//  Organization.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class Organization: Decodable {
    var id: Int
    var name: String
//    var description: String
    var website: String
    var workHours: String
    var rating: Double
    var pictureData: Data?
//    var type: OrganizationType
    
    init() {
        self.id = 0
        self.name = ""
        self.website = ""
        self.workHours = ""
        self.rating = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
//        case description = "description"
//        case pictureData = "picture"
        case website = "website"
        case workHours = "workHours"
        case rating = "rating"
    }
}

enum OrganizationType {
    case restaurant
    case museum
    case cinema
    case tourism
    case unknown
}
