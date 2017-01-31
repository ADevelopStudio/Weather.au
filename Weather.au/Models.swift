//
//  Models.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation


struct WeatherDetail {
    var title: String
    var details: String
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}


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

struct Weather {
    var icon: String
    var descr: String
    init(icon: String, descr: String) {
        self.descr = descr
        self.icon = "http://openweathermap.org/img/w/\(icon).png"
    }
}


struct MainForecastData {
    var humidity: Int
    var pressure: Int
    var maxTemp: Double
    var minTemp: Double
    var currentTemp: Double

    init(humidity: Int, pressure: Int, maxTemp: Double, minTemp: Double, currentTemp: Double ) {
        self.humidity = humidity
        self.pressure = pressure
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.currentTemp = currentTemp
    }

}

class Forecast: NSObject {
    var sunsetTime =  Date()
    var sunriseTime =  Date()
    var calculationTime =  Date()
    var visibility = 0
    var cloudiness = 0
    var wind: Wind!
    var mainForecastData: MainForecastData!
    var cityName = ""
    var cityId = ""
    var weather: Weather!
    
    var isValid: Bool {
        return cityName.length > 0 && cityId.length > 0
    }
    
    override init() {
        super.init()
    }
    

    init(json: JSON) {
        visibility =  json["visibility"].intValue
        cityName =  json["name"].stringValue
        cityId =  json["id"].stringValue
        
        sunsetTime = Date(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
        sunriseTime = Date(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
        calculationTime = Date(timeIntervalSince1970: json["dt"].doubleValue)
        
        cloudiness = json["clouds"]["all"].intValue
        
        let mainData = json["main"]
        mainForecastData  = MainForecastData(humidity: mainData["humidity"].intValue, pressure: mainData["pressure"].intValue, maxTemp: mainData["temp_max"].doubleValue, minTemp: mainData["temp_min"].doubleValue, currentTemp: mainData["temp"].doubleValue)
        
        let windData = json["wind"]
        wind = Wind(speed: windData["speed"].doubleValue, degree: windData["deg"].intValue)
        
        let weatherData = json["weather"]
        weather = Weather(icon: weatherData["icon"].stringValue, descr: weatherData["description"].stringValue)
        
    }

    
    
}
