//
//  Network.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "get"
    case put = "put"
}

struct Network {
    func buildRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return dataTaskPublisher
    }
}
