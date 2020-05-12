//
//  Scanning.swift
//  YourSmartCity
//
//  Created by Parshakov Alexander on 5/5/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkService.Scanning {
    private static let buildingsURL = NetworkService.baseURL + "buildings"
    
    static func getBuilding(byId id: Int, completion: @escaping (Result<Building, Error>) -> Void) {
        let requestURL = "\(NetworkService.Scanning.buildingsURL)"
        let parameters = ["id" : id]
        AF.request(requestURL, method: .get, parameters: parameters).responseDecodable { (response: DataResponse<Building, AFError>) in
            do {
                let building = try JSONDecoder().decode(Building.self, from: response.data ?? Data())
                completion(.success(building))
            } catch let jsonError {
                print("Failed to decode", jsonError)
                completion(.failure(jsonError))
            }
        }
    }
}
