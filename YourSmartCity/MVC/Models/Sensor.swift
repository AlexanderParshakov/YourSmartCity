//
//  Sensor.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

final class Sensor {
    var id: Int
    var title: String
    var description: String
    var value: Float
    var standard: Float
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.value = 0
        self.standard = 0
    }
}
