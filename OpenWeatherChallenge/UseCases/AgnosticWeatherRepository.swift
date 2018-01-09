//
//  FetchForecastFromServer.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

struct DayForecast {
    let day: Date
    let forecast: [Weather]
}

protocol WeatherRepository {
    func fetchForecast(_ completion: @escaping ([DayForecast]?) -> ())
}

class AgnosticWeatherRepository<Parser: WeatherParser, Provider: WeatherProvider>: WeatherRepository where Provider.Returnable == Parser.Parseable {
    
    func fetchForecast(_ completion: @escaping ([DayForecast]?) -> ()) {
        Provider().obtainData { (result) in
            guard let result = result, let weatherList = Parser().parse(all: result) else {
                completion(nil)
                return
            }
            
            let dates = Array(Set(weatherList.map({
                return Calendar.current.startOfDay(for: $0.date)
            })))
            
            let forecasts: [DayForecast] = dates.map({
                let date = $0
                let weathers = weatherList.filter({
                    Calendar.current.startOfDay(for: $0.date) == date
                }).sorted(by: {
                    return $0.date < $1.date
                })
                return DayForecast(day: date, forecast: weathers)
            }).sorted(by: {
                return $0.day < $1.day
            })
            
            completion(forecasts)
        }
    }
}
