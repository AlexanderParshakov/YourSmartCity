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
    var name: String?
//    var latitude: Float
//    var longitude: Float
//    var historicalAccount: String
    var pictureData: Data?
    var country: String
    var region: String
    var city: String
    var street: String
    var house: String
    var cinemas: [Cinema]?
    var museums: [Museum]?
    var restaurants: [Restaurant]?
    
    var fullAddress: String {
        return "\(country), \(region), г. \(city), ул. \(street), д. \(house)"
    }
    
    init() {
        self.id = 0
        self.country = ""
        self.region = ""
        self.city = ""
        self.street = ""
        self.house = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pictureData = "picture"
        case country = "country"
        case region = "region"
        case city = "city"
        case street = "street"
        case house = "house"
        case cinemas = "cinemas"
        case restaurants = "restaurants"
    }
    
}

enum BuildingType {
    case office
    case residential
    case educational
    case entertainment
    case unknown
}
