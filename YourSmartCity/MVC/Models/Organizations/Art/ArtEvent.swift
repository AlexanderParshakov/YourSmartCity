//
//  ArtEvent.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

enum ArtEventType: String, Codable {
    
    case movie = "movie"
    case performance = "performance"
    case exhibition = "exhibition"
    case unknown = "unknown"
}


class ArtEvent: Decodable {
    var id: Int
    var title: String
    var description: String
    var pictureData: Data?
    var showings: [Showing]?
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.pictureData = Data()
        self.showings = []
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case pictureData = "pictureData"
        case showings = "showings"
    }
}


final class Movie: ArtEvent {
    
}

final class Exhibition: ArtEvent {
    
}


