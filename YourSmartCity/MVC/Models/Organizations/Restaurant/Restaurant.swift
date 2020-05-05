//
//  Restaurant.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class Restaurant: Organization {
    
    override init() {
        super.init()
        
        self.type = .restaurant
    }
    
}
