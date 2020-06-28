//
//  WeatherModel.swift
//  Weather
//  Created by Nareshri Babu on 21/04/2020.
//  Concept by London App Brewery
//  Copyright © 2020 Nareshri Babu. All rights reserved.
//  This app was created for learning purposes.
//  All images were only used for learning purposes and do not belong to me.
//  All sounds were only used for learning purposes and do not belong to me.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName : String
    let temperature: Double
    
    var temperatureString : String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName: String {
        
        switch conditionId {
        case 200...232:
            //thunderstorm
            return "cloud.bolt.rain"
        case 300...321:
            //drizel
            return "cloud.drizzle"
        case 500...531:
            //rain
            return "cloud.rain"
        case 600...622:
            //snow
            return "cloud.snow"
        case 701...781:
            //Atmosphere: mist smoke haze tornado
            return "cloud.fog"
        case 800:
            //clear
            return "sun.max"
        case 801...804:
            //clouds
            return "cloud.bolt"
        default:
            return "cloud"
            
        }
        
    }
    
}
