//
//  Constants.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation

struct Constants {
    
    static let BASE_URL = "https://www.metaweather.com/api/location/"
    
    static func getTemperature(from value: Double ) -> String {
        return NSString(format: "%@%@", "\(Int(value))","\u{00B0}") as String
    }
}
