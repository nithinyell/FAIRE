//
//  Cities.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import Combine

protocol CitiesDelegate: AnyObject {
    func fetchCities(cities: [City]?)
}

class Cities {
    
    weak var citiesDelegate: CitiesDelegate?
    
    func fetchCitiesList() {
        
        let cities = [
            City(title: "🇨🇦 Toronto", id: 4118),
            City(title: "🌉 San Francisco", id: 2487956),
            City(title: "🗼 London", id: 44418),
            City(title: "🗽 New York", id: 2459115),
            City(title: "🐂 Chicago", id: 2379574),
            City(title: "🎊 Los Angeles", id: 2442047),
            City(title: "🌇 Tokyo", id: 1118370),
            City(title: "🏝 Sydney", id: 1105779),
        ]
        
        citiesDelegate?.fetchCities(cities: cities)
    }
}
