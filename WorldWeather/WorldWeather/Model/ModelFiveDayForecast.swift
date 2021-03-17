//
//  ModelFiveDayForecast.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/16/21.
//

import Foundation

class ModelFiveDayForecast{
    
    var date : String = ""
    var maxTemp : Int = 0
    var minTemp : Int = 0
    var maxIcon : Int = 0
    var minIcon : Int = 0
    var day : String = ""
    
    init(_ date : String, _ maxTemp : Int, _ minTemp : Int, _ maxIcon : Int, _ minIcon : Int, _ day : String) {
        self.date = date
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.maxIcon = maxIcon
        self.minIcon = minIcon
        self.day = day
    }
}
