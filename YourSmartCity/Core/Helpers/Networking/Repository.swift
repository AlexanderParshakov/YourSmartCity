//
//  Repository.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation

class Repository {
    private init() {}
    
    static func getMovies(completion: @escaping(Result<Array<Movie>, Error>) -> Void) {
        NetworkService.Events.Movies.getAll { (result) in
            completion(result)
        }
    }
    
    static func getThumbnailRestaurants() -> [Restaurant] {
        return NetworkService.getThumbnailRestaurants()
    }
    
    static func getSensors() -> [Sensor] {
        return NetworkService.getSensors()
    }
}
