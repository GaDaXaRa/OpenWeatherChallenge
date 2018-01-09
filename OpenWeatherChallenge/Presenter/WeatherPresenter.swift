//
//  WeatherPresenter.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 9/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol WeatherListView: class {
    func reload()
}

class WeatherPresenter: NSObject {
    
    weak var view: WeatherListView? {
        didSet {
            loadForecast()
        }
    }
    
    private var forecasts: [DayForecast]? {
        didSet {
            view?.reload()
        }
    }
    
    private func loadForecast() {
        WeatherRepository<JSONWeatherParser, HttpJSONProvider>().fetchForecast { [weak self] (forecasts) in
            self?.forecasts = forecasts
        }
    }
    
    func numberOfDays() -> Int {
        return forecasts?.count ?? 0
    }
    
    func dayViewModel(at indexPath: IndexPath) -> DayCellViewModel {
        guard let forecasts = forecasts else {fatalError("Trying to access forecast before been loaded")}
        return forecasts[indexPath.row]
    }
    
    func numberOfTemperature(at index: Int) -> Int {
        return forecasts?[index].forecast.count ?? 0
    }
    
    func temperatureViewModel(in index: Int, at indexPath: IndexPath) -> TemperatureCellViewModel {
        guard let forecasts = forecasts else {fatalError("Trying to access forecast before been loaded")}
        return forecasts[index].forecast[indexPath.row]
    }
}

extension DayForecast: DayCellViewModel {
    var dayText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: day)
    }   
}

extension Weather: TemperatureCellViewModel {
    var timeText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var temperatureText: String {
        return String(temperature)
    }    
}
