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

enum WeatherSource: Int {
    case Remote, Local
    
    var repository: WeatherRepository {
        switch self {
        case .Remote:
            return AgnosticWeatherRepository<JSONWeatherParser, HttpJSONProvider>()
        case .Local:
            return AgnosticWeatherRepository<CSVWeatherParser, DiskCSVProvider>()
        }
    }
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
    
    private var currentSource: WeatherSource? = .Remote {
        didSet {
            loadForecast()
        }
    }
    
    private func loadForecast() {
        currentSource?.repository.fetchForecast { [weak self] (forecasts) in
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
    
    func didChangeSource(to index: Int) {
        currentSource = WeatherSource(rawValue: index)
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
        return String(Int(temperature))
    }    
}
