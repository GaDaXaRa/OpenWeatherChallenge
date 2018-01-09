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
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        return cell
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfTemperature(at: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "temperatureCell", for: indexPath) as! TemperatureCollectionViewCell
        cell.configure(with: presenter.temperatureViewModel(in: collectionView.tag, at: indexPath))
        return cell
    }
}
