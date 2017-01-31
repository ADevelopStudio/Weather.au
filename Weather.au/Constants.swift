//
//  Constants.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation


/*
 For easier future customization and support
*/
let arrayOfCities = Array(arrayLiteral: City(city: .sydney), City(city: .melbourne), City(city: .brisbane))
//let arrayOfCities = Array(arrayLiteral: City(city: .sydney), City(city: .melbourne), City(city: .brisbane))



struct Constants {
    static let baseURLPath = "http://api.openweathermap.org/data/2.5/weather"
//    static let apiKey = "6fb230ebd5acaa6946bf6d09830d27fc" //second key just in case
    static let apiKey = "4a6392d6d156d72879f46bad2504ec52"
 
    enum City: String {
        static let allValues = [brisbane, sydney, melbourne]
        case brisbane = "Brisbane", sydney = "Sydney", melbourne = "Melbourne"
        var id: String {
            switch self {
            case .brisbane:
                return "2174003"
            case .sydney:
                return "4163971"
            case .melbourne:
                return "2147714"
            }
        }
    }
}
