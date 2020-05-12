//
//  NetworkManager.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/11/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

final class NetworkService {
    private init() {}
    
    static let baseURL = "https://smartcitywebservice.azurewebsites.net/api/"
    
    struct Events {
        private init() {}
        
        struct Movies {
            private init() {}
        }
        struct Museums {
            private init() {}
        }
    }
    
    struct Scanning {
        private init() {}
        
    }
    
}

extension NetworkService {
    static func getThumbnailMovies() -> [Movie] {
        let bloodshotMovie = Movie()
        bloodshotMovie.id = 0
        bloodshotMovie.pictureData = UIImage(named: "Bloodshot")?.pngData()
        bloodshotMovie.title = "Бладшот"
        
        let aquamanMovie = Movie()
        aquamanMovie.id = 1
        aquamanMovie.pictureData = UIImage(named: "Aquaman")?.pngData()
        aquamanMovie.title = "Аквамен"
        
        let irishmanMovie = Movie()
        irishmanMovie.id = 2
        irishmanMovie.pictureData = UIImage(named: "The Irishman")?.pngData()
        irishmanMovie.title = "Ирландец"
        
        
        return [bloodshotMovie, aquamanMovie, irishmanMovie]
    }
    
    static func getThumbnailRestaurants() -> [Restaurant] {
        let vietnamese = Restaurant()
        vietnamese.pictureData = UIImage(named: "Вьетнамская кухня")!.pngData()
        vietnamese.name = "«Вьетнамская кухня»"
        
        let loft = Restaurant()
        loft.pictureData = UIImage(named: "Loft Garden")!.pngData()
        loft.name = "«Loft Garden»"
        
        let italiano = Restaurant()
        italiano.pictureData = UIImage(named: "Итальяно")!.pngData()
        italiano.name = "«Итальяно»"
        
        let cabinet = Restaurant()
        cabinet.pictureData = UIImage(named: "Cabinet")!.pngData()
        cabinet.name = "«Cabinet Cafe»"
        
        
        return [vietnamese, loft, italiano, cabinet]
    }
    
    static func getSensors() -> [Sensor] {
        let electricity = Sensor()
        electricity.title = "Потребление электроэнергии"
        electricity.description = "Количество энергии, потребляемое домом в исчислении Вт⋅ч (ватт-час)"
        electricity.value = Float.random(in: 100...500)
        electricity.standard = 400
        
        let water = Sensor()
        water.title = "Потребление воды"
        water.description = "Количество воды, потребляемое домом в исчислении Вт⋅ч (ватт-час)"
        water.value = Float.random(in: 100...500)
        water.standard = 400
        
        return [electricity, water]
    }
}
