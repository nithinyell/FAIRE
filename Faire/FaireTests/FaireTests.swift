//
//  FaireTests.swift
//  FaireTests
//
//  Created by Nithin 3 on 09/04/22.
//

import XCTest
import Combine

@testable import Faire

class FaireTests: XCTestCase {
    
    var subscribers = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTemperature() throws {
        XCTAssertEqual(NSString(format: "%@%@", "6","\u{00B0}") as String, Constants.getTemperature(from: 6.890))
        XCTAssertEqual(NSString(format: "%@%@", "17","\u{00B0}") as String, Constants.getTemperature(from: 17.00))
        XCTAssertEqual(NSString(format: "%@%@", "120","\u{00B0}") as String, Constants.getTemperature(from: 120.897678))
        XCTAssertTrue(Constants.getTemperature(from: 3).isEmpty == false, "Return Value Present")
    }

    func testWeatherDetails() {
        let model = CityDetailsViewModel()
        model.cityWeatherDetailsDelegate = CityWeatherDetails()
        model.weatherDetails("44418")?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("done")
            case .failure(_):
                print("fail")
            }
        }, receiveValue: { weatherInfo in
            XCTAssertNotNil(weatherInfo)
            XCTAssertNotNil(weatherInfo, "")
        }).store(in: &subscribers)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
