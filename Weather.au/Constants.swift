//
//  Constants.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit
import Haneke

/*
 For easier future customization and support new cities:
*/

let forecastCities = Array(arrayLiteral:
        City(name: "Brisbane", id: "2174003"),
        City(name: "Sydney", id: "4163971"),
        City(name: "Melbourne", id: "2147714"))



struct Constants {
    static let baseURLPath = "http://api.openweathermap.org/data/2.5/weather"
//    static let apiKey = "6fb230ebd5acaa6946bf6d09830d27fc" //second key just in case
    static let apiKey = "4a6392d6d156d72879f46bad2504ec52"
    static let screenWight:CGFloat = UIScreen.main.bounds.width
    static let screenHeight:CGFloat = UIScreen.main.bounds.height
    static let cacheImages = Shared.imageCache
}
