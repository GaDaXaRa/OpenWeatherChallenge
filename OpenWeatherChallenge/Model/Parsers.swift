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
    func parse(one: Parseable) -> Weather?
    func parse(all: Parseable) -> [Weather]?
}

struct JSONWeatherParser: WeatherParser {
    typealias Parseable = [String: Any]
    
    func parse(all items: [String : Any]) -> [Weather]? {
        guard let list = items["list"] as? [[String: Any]] else {return nil}
        return list.flatMap({parse(one: $0)})
    }
    
    func parse(one item: [String : Any]) -> Weather? {
        guard let dateTimestamp = item["dt"] as? Double, let main = item["main"] as? [String: Any], let temperature = main["temp"] as? Double else {
            return nil
        }
        
        return Weather(temperature: temperature, date: Date(timeIntervalSince1970: dateTimestamp))
    }
}

struct CSVWeatherParser: WeatherParser {    
    typealias Parseable = String
    
    func parse(all items: String) -> [Weather]? {
        return items.components(separatedBy: CharacterSet.newlines).flatMap({parse(one: $0)})
    }
    
    func parse(one item: String) -> Weather? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let components = item.components(separatedBy: ",")
        guard components.count > 1, let date = dateFormatter.date(from: components.first!), let temperature = Double(components[1]) else {
            return nil            
        }
        
        return Weather(temperature: temperature, date: date)
    }
}
