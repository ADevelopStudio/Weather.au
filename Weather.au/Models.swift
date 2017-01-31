//
//  Models.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation

class City: NSObject {
    var name = ""
    var id = ""
    var forecast: Forecast?
    var errorMessage = ""
    
    override init() {
        super.init()
    }
    
    init(name: String, id: String ) {
        self.name = name
        self.id = id
    }
    
    init(cityId: String ) { //Posible to create object of class City if you do not know city name
        self.id = cityId
    }
    
}

struct Wind {
    var speed: Double
    var degree: Int
    init(speed: Double, degree: Int) {
        self.degree = degree
        self.speed = speed
    }
}

struct MainForecastData {
    var humidity: Int
    var pressure: Int
    var maxTemp: Double
    var minTemp: Double
    var currentTemp: Double
    var currentTempString: String
    
    init(humidity: Int, pressure: Int, maxTemp: Double, minTemp: Double, currentTemp: Double ) {
        self.humidity = humidity
        self.pressure = pressure
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.currentTemp = currentTemp
        self.currentTempString = "\(currentTemp > 0 ? "+" : "")\(currentTemp.roundTo(places: 1)) ºC"
    }
}

class Forecast: NSObject {
    var sunsetTime =  NSDate()
    var sunriseTime =  NSDate()
    var visibility = 0
    var wind: Wind!
    var mainForecastData: MainForecastData!
    var cityName = ""
    var cityId = ""
    var isLoaded = false
    
    
    var isValid: Bool {
        return cityName.length > 0 && cityId.length > 0
    }
    
    override init() {
        super.init()
    }
    

    init(json: JSON) {
        let mainData = json["main"]
        mainForecastData  = MainForecastData(humidity: mainData["humidity"].intValue, pressure: mainData["pressure"].intValue, maxTemp: mainData["temp_max"].doubleValue, minTemp: mainData["temp_min"].doubleValue, currentTemp: mainData["temp"].doubleValue)
        
        let windData = json["wind"]
        wind = Wind(speed: windData["speed"].doubleValue, degree: windData["deg"].intValue)
        visibility =  json["visibility"].intValue
        cityName =  json["name"].stringValue
        cityId =  json["id"].stringValue
        isLoaded = true
    }
    
    func updateDataWith(newForecast : Forecast) {
        
    }
    
    
}
