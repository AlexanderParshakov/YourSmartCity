//
//  Events.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/30/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkManager.Events.Movies {
    static let moviesURL = "https://smartcitywebservice.azurewebsites.net/api/movies"
    
    static func getAll(completion: @escaping (Result<Array<Movie>, Error>) -> Void) {
        AF.request(moviesURL, method: .get).responseDecodable { (response: DataResponse<Array<Movie>, AFError>) in
            do {
                let movies = try JSONDecoder().decode(Array<Movie>.self, from: response.data ?? Data())
                completion(.success(movies))
            } catch let jsonError {
                print("Failed to decode", jsonError)
                completion(.failure(jsonError))
            }
        }
    }
}
