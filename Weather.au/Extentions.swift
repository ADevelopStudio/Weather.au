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
