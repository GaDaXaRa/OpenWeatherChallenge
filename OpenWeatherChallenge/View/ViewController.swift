//
//  ViewController.swift
//  OpenWeatherChallenge
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!    
    @IBOutlet weak var presenter: WeatherPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        presenter.view = self
    }
}

extension ViewController: WeatherListView {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as! DayTableViewCell
        cell.configure(with: presenter.dayViewModel(at: indexPath))
        return cell
    }
}
