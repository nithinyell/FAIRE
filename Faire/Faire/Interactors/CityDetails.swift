//
//  CityDetails.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import Combine

protocol CityWeatherDetailsDelegate {
    func fetchWeatherInfo(locationId: String) -> AnyPublisher<WeatherInfo, Error>
}

class CityWeatherDetails: CityWeatherDetailsDelegate {
    
    func fetchWeatherInfo(locationId: String) -> AnyPublisher<WeatherInfo, Error> {
        
        guard let url = URL(string: Constants.BASE_URL + locationId) else {
            return AnyPublisher(Fail<WeatherInfo, Error>(error: URLError(.badURL)))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return Network().buildRequest(request).receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
}
