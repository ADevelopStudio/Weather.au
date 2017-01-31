//
//  Connections.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation
import Alamofire

let connectionManager = Connections()

class Connections: NSObject {
    
    func getWeatherOf(city: Constants.City,  completion: @escaping(_ success: Bool, _ error: String, _ forecast: Forecast) -> ()) {
        let parameters: Parameters = [
            "id" : city.id,
            "units" : "metric",
            "APPID" : Constants.apiKey
        ]
        print(parameters)
//        Alamofire.request(Constants.baseURLPath + "?id=\(city.id)&units=metric&APPID=\(Constants.apiKey)", parameters: nil).responseJSON{
            Alamofire.request(Constants.baseURLPath, parameters: parameters).responseJSON{
            (response) in
            print("getCityWeather \(city.rawValue)")
            if response.result.isFailure || response.result.value == nil {
                completion(false, "Error getting weather for \(city.rawValue)", Forecast())
                return
            }
            let responseJson = JSON(response.result.value!)
            print(responseJson)
            if responseJson["message"].stringValue.length > 0 { //SOME ERROR FROM API
                completion(false, responseJson["message"].stringValue, Forecast())
            } else {
                let forecast =  Forecast(json: responseJson)
                if forecast.isValid {
                    completion(true, "", forecast)
                } else {
                    completion(false, "Error getting data for \(city.rawValue)", Forecast())
                }
            }
        }
    }
    
}
