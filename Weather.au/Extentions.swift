//
//  Extentions.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation

extension String {
    var length: Int{
        let str:NSString = NSString(string: self)
        if str == "\n" {
            return 0
        }
        return str.length
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
