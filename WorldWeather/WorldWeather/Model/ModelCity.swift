//
//  ModelCity.swift
//  WorldWeather
//
//  Created by Fancy Tseng on 3/9/21.
//

import Foundation


class ModelCity{
    
    var cityKey : String = ""
    var cityName : String = ""
    
    init(_ cityKey : String, _ cityName: String) {
        self.cityKey = cityKey
        self.cityName = cityName
    }
}
