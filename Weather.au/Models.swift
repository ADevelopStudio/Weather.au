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
    var descr: String
    init(speed: Double, degree: Double) {
        var direction: String {
        switch degree {
        case 348.75...360.0, 0..<11.25:
            return "North"
        case 11.25..<33.75:
            return "NNE"
        case 33.75..<56.25:
            return "NorthEast"
        case 56.25..<78.75:
            return "ENE"
        case 78.75..<101.25:
            return "East"
        case 101.25..<123.75:
            return "ESE"
        case 123.75..<146.25:
            return "SouthEast"
        case 146.25..<168.75:
            return "SSE"
        case 168.75..<191.25:
            return "South"
        case 191.25..<213.75:
            return "SSW"
        case 213.75..<236.25:
            return "SouthWest"
        case 236.25..<258.75:
            return "WSW"
        case 258.75..<281.25:
            return "West"
        case 281.25..<303.75:
            return "WNW"
        case 303.75..<326.25:
            return "NorthWest"
        case 326.25..<348.75:
            return "NNW"
        default:
            return ""
        }
        }
        self.descr = "\(speed.roundTo(places: 1)) m/s \(direction)(\(Int(degree)))"
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
    var humidity: String
    var pressure: String
    var maxTemp: String
    var minTemp: String
    var currentTemp: String

    init(humidity: Int, pressure: Int, maxTemp: Double, minTemp: Double, currentTemp: Double ) {
        self.humidity = "\(humidity) %"
        self.pressure = "\(pressure) hPa"
        self.maxTemp = maxTemp.degreeCelsius
        self.minTemp = minTemp.degreeCelsius
        self.currentTemp = currentTemp.degreeCelsius
    }

}

class Forecast: NSObject {
    var sunsetTime =  ""
    var sunriseTime =  ""
    var calculationTime =  ""
    var visibility = ""
    var cloudiness = ""
    var wind = ""
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
        visibility = "\(json["visibility"].intValue) meters"
        cityName =  json["name"].stringValue
        cityId =  json["id"].stringValue
        
        sunsetTime = Date(timeIntervalSince1970: json["sys"]["sunset"].doubleValue).justTime()
        sunriseTime = Date(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue).justTime()
        calculationTime = Date(timeIntervalSince1970: json["dt"].doubleValue).formatted("K:mma dd.MM.yyyy")
        
        cloudiness = "\(json["clouds"]["all"].intValue) %"
        
        let mainData = json["main"]
        mainForecastData  = MainForecastData(humidity: mainData["humidity"].intValue, pressure: mainData["pressure"].intValue, maxTemp: mainData["temp_max"].doubleValue, minTemp: mainData["temp_min"].doubleValue, currentTemp: mainData["temp"].doubleValue)
        
        let windData = json["wind"]
        wind = Wind(speed: windData["speed"].doubleValue, degree: windData["deg"].doubleValue).descr
        
        let weatherData = json["weather"]
        weather = Weather(icon: weatherData["icon"].stringValue, descr: weatherData["description"].stringValue)
        
    }

    
    
}
