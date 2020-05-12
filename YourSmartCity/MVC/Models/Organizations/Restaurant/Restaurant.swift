//
//  Restaurant.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class Restaurant: Organization {
    
    var averageCheck: Int
    
    override init() {
        self.averageCheck = 0
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        self.averageCheck = 0
        super.init()
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}
