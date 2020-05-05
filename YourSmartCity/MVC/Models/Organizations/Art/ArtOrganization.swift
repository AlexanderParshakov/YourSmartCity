//
//  Cinema.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class ArtOrganization: Organization {
    var events: [ArtEvent]
    
    override init() {
        self.events = []
        
        super.init()
    }
}


// MARK: - Abstract Functions
extension ArtOrganization {
    
    func getEvents() { }
    
}
