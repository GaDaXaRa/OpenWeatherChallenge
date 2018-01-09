//
//  DayTableViewCell.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 9/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol DayCellViewModel {
    var dayText: String {get}
}

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    func configure(with viewModel: DayCellViewModel) {
        titleLabel.text = viewModel.dayText
    }
}
