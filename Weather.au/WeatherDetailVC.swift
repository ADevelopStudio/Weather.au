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
        return !isLoaded ? 0 : detailedData.count
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
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var conditionLbl: MAGlowingLabel!
    @IBOutlet weak var conditionImg: UIImageView!
    
    var city: City?
    var detailedData = Array<WeatherDetail>()
    var isLoaded = false
    
    
    override func viewDidLoad() {
     super.viewDidLoad()
        self.view.backgroundColor = .darkGray

        if city == nil || city?.forecast == nil {
            self.showErrorCard(title: "Error", message: "Data was loaded incorrectly")
            _ = self.navigationController?.popViewController(animated: true)
            return
        }
        
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.backgroundColor = .clear
        
        fillData()
    }
    
    func fillData(){
        title = city!.name
        conditionLbl.text = city!.forecast!.weather.descr.uppercased()
        self.temperatureLbl.text = self.city!.forecast!.mainForecastData.currentTemp
        conditionLbl.addGlowingEffect()
        
        if let url = URL(string: city!.forecast!.weather.icon) { //Image loading and chaching
            Constants.cacheImages.fetch(URL: url).onSuccess { image in
                self.conditionImg.image = image
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !isLoaded {
            //Minor animation of data apearing
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 , execute: {
                self.isLoaded = true
                self.createDetailedForecast()
                self.table.reloadSections([0], with: .automatic)
            })
        }
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
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        let string: String = "Today's temperature in \(city!.name) is \(self.city!.forecast!.mainForecastData.currentTemp)"
        let shareLink = "http://makemeapp.com.au"
        let URL = NSURL(string: shareLink)
        let activityViewController = UIActivityViewController(activityItems: [string, URL!, self.conditionImg.image ?? UIImage()], applicationActivities: nil)
        self.present(activityViewController, animated: true) {
        }
    }
    
    
}
