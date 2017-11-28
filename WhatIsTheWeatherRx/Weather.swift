//
//  Weather.swift
//  WhatIsTheWeatherRx
//
//  Created by Vladimir Nevinniy on 28.11.2017.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import SwiftyJSON

class Weather {
    var name: String?
    var degrees: Double?
    
    init(json: AnyObject) {
        let data = JSON(json)
        self.name = data["name"].stringValue
        self.degrees = data["main"]["temp"].doubleValue
    }
}
