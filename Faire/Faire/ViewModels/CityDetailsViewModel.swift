//
//  CityDetailsViewModel.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import Combine

class CityDetailsViewModel {
    
    var cityWeatherDetailsDelegate: CityWeatherDetailsDelegate?

    func weatherDetails(_ locationId: String) -> AnyPublisher<WeatherInfo, Error>? {
        
        return cityWeatherDetailsDelegate?.fetchWeatherInfo(locationId: locationId).receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
}

