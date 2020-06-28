//
//  WeatherData.swift
//  Weather
//  Created by Nareshri Babu on 21/04/2020.
//  Concept by London App Brewery
//  Copyright © 2020 Nareshri Babu. All rights reserved.
//  This app was created for learning purposes.
//  All images were only used for learning purposes and do not belong to me.
//  All sounds were only used for learning purposes and do not belong to me.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main: Main
    let weather : [Weather]
}

struct Main : Codable {
    let temp: Double
}

struct Weather : Codable {
    let description: String //can use this later fro additonal functionality
    let id : Int
}
