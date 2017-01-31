//
//  Models.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation

class City: NSObject {
    var city: Constants.City!
    var weather: String = ""
    var errorMessage: String = ""
    override init(){
        super.init()
    }
    
    init(city: Constants.City) {
        self.city = city
    }
}
