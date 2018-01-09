//
//  DataProviders.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

protocol WeatherProvider {
    associatedtype Returnable
    func obtainData(_: @escaping (Returnable?) -> ())
    init()
}

class HttpJSONProvider: WeatherProvider {
    typealias Returnable = [String: Any]
    
    required init() {
        
    }
    
    private let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=London&appid=60f59ba7225e7acf3212a80f80a8b990")!
    
    func obtainData(_ completion: @escaping ([String : Any]?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(nil)
                return
            }
            
            completion(json)
        }.resume()
    }
}

class DiskCSVProvider: WeatherProvider {
    typealias Returnable = String
    
    required init() {
        
    }
    
    private let filePath = Bundle.main.url(forResource: "weather", withExtension: "csv")!
    
    func obtainData(_ completion: @escaping (String?) -> ()) {
        DispatchQueue.global().async {
            guard let text = try? String(contentsOf: self.filePath, encoding: .utf8) else {
                completion(nil)
                return
            }
            
            completion(text)
        }
    }
}
