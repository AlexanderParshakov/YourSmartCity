//
//  Organization.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class Organization {
    var id: Int
    var title: String
    var description: String
    var url: String
    var workHours: String
    var rating: Double
    var picture: UIImage
    var type: OrganizationType
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.url = ""
        self.workHours = ""
        self.rating = 0
        self.picture = UIImage()
        self.type = .unknown
    }
}

enum OrganizationType {
    case restaurant
    case museum
    case cinema
    case tourism
    case unknown
}
