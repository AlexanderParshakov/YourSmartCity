//
//  Building.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

final class Building: Decodable {
    var id: Int
    var name: String
    var latitude: Float
    var longitude: Float
    var historicalAccount: String
    var pictureData: Data?
    var country: String
    var region: String
    var city: String
    var street: String
    var house: String
    
    init() {
        self.id = 0
        self.name = ""
        self.latitude = 0
        self.longitude = 0
        self.historicalAccount = ""
        self.country = ""
        self.region = ""
        self.city = ""
        self.street = ""
        self.house = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case latitude = "latitude"
        case longitude = "longitude"
        case historicalAccount = "historicalAccount"
        case pictureData = "picture"
        case country = "country"
        case region = "region"
        case city = "city"
        case street = "street"
        case house = "house"
    }
}

enum BuildingType {
    case office
    case residential
    case educational
    case entertainment
    case unknown
}
