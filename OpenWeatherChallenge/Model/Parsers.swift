//
//  Parsers.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

protocol WeatherParser {
    associatedtype Parseable
    func parse(info: Parseable) -> Weather?
}

struct JSONWeatherParser: WeatherParser {
    typealias Parseable = [String: Any]
    
    func parse(info: [String : Any]) -> Weather? {
        guard let dateTimestamp = info["dt"] as? Double, let main = info["main"] as? [String: Any], let temperature = main["temp"] as? Double else {
            return nil
        }
        
        return Weather(temperature: temperature, date: Date(timeIntervalSince1970: dateTimestamp))
    }
}

struct CSVWeatherParser: WeatherParser {
    typealias Parseable = String
    
    func parse(info: String) -> Weather? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let components = info.components(separatedBy: ",")
        guard components.count > 1, let date = dateFormatter.date(from: components.first!), let temperature = Double(components[1]) else {
            return nil            
        }
        
        return Weather(temperature: temperature, date: date)
    }
}
