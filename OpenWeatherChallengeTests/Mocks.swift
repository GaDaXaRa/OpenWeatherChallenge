//
//  Mocks.swift
//  OpenWeatherChallengeTests
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct Mocks {
    static let singleWeatherCSV = "2017-02-16 13:00:00,286.67"
    
    static let singleWeatherJSON = try! JSONSerialization.jsonObject(with: Mocks.singleWeatherString.data(using: .utf8)!, options: []) as! [String: Any]

    static let singleWeatherString = """
        {
        \"dt\":1487246400,
        \"main\":{
        \"temp\":286.67,
        \"temp_min\":281.556,
        \"temp_max\":286.67,
        \"pressure\":972.73,
        \"sea_level\":1046.46,
        \"grnd_level\":972.73,
        \"humidity\":75,
        \"temp_kf\":5.11
        },
        \"weather\":[
        {
        \"id\":800,
        \"main\":\"Clear\",
        \"description\":\"clear sky\",
        \"icon\":\"01d\"
        }
        ],
        \"clouds\":{
        \"all\":0
        },
        \"wind\":{
        \"speed\":1.81,
        \"deg\":247.501
        },
        \"sys\":{
        \"pod\":\"d\"
        },
        \"dt_txt\":\"2017-02-16 12:00:00\"
        }
        """
}
