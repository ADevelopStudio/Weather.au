//
//  WeatherDetailVC.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit

extension WeatherDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = detailedData[indexPath.row].title
        cell.detailTextLabel?.text = detailedData[indexPath.row].details
        return cell
    }
}

class WeatherDetailVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var city: City?
    var detailedData = Array<WeatherDetail>()
    
    override func viewDidLoad() {
     super.viewDidLoad()
        if city == nil || city?.forecast == nil {
            self.showErrorCard(title: "Error", message: "Data was loaded incorrectly")
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        
        title = city!.name
        createDetailedForecast()
    }
    
    func createDetailedForecast() {
        detailedData = []
        detailedData.append(WeatherDetail(title: "Mininum temperature", details: city!.forecast!.mainForecastData.minTemp))
        detailedData.append(WeatherDetail(title: "Maximum temperature", details: city!.forecast!.mainForecastData.maxTemp))
        detailedData.append(WeatherDetail(title: "Humidity", details: city!.forecast!.mainForecastData.humidity))
        detailedData.append(WeatherDetail(title: "Atmospheric pressure", details: city!.forecast!.mainForecastData.pressure))
        detailedData.append(WeatherDetail(title: "Visibility", details: city!.forecast!.visibility))
        detailedData.append(WeatherDetail(title: "Wind", details: city!.forecast!.wind))
        detailedData.append(WeatherDetail(title: "Cloudiness", details: city!.forecast!.cloudiness))
        detailedData.append(WeatherDetail(title: "Sunrise time", details: city!.forecast!.sunriseTime))
        detailedData.append(WeatherDetail(title: "Sunset time", details: city!.forecast!.sunsetTime))
        detailedData.append(WeatherDetail(title: "Updated", details: city!.forecast!.calculationTime))
        table.reloadData()
    }
    
    
}
