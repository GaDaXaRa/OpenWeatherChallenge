//
//  TemperatureCollectionViewCell.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 9/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol TemperatureCellViewModel {
    var timeText: String {get}
    var temperatureText: String {get}
}

class TemperatureCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(with viewModel: TemperatureCellViewModel) {
        timeLabel.text = viewModel.timeText
        temperatureLabel.text = viewModel.temperatureText
    }
}
