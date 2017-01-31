//
//  Extentions.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import Foundation
import ISMessages

extension Foundation.Date {
    struct Date {
        static var formatter = DateFormatter()
    }
    var localDate : DateFormatter{
        let localeIdentifier =  "en_US"
        let locale = Locale(identifier: localeIdentifier)
        Date.formatter.locale = locale
        return Date.formatter
    }
    
    func formatted(_ format:String) -> String {
        Date.formatter.dateFormat = format
        return localDate.string(from: self)
    }
    
    func justTime() -> String {
        return self.formatted("K:mma")
    }

}


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
    
    var degreeCelsius: String  {
        return "\(self > 0 ? "+" : "")\(self.roundTo(places: 1)) ºC"
    }
}

extension UIViewController {
    func showErrorCard(title: String, message: String)  {
        ISMessages.showCardAlert(withTitle: title, message: message, duration: 1, hideOnSwipe: true, hideOnTap: true, alertType: .error, alertPosition: .top, didHide: nil)
    }
    

}
