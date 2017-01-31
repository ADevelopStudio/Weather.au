//
//  ViewController.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit

//Separation UITableView delagate and dataSourse methods to better code reading

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        let element =  forecastCities[indexPath.row]
        cell.setState(.loading, forecastCity: element)
        connectionManager.getWeatherOf(city: element, completion: {
            success, errormessage, forecast in
            element.errorMessage = errormessage
            element.forecast = forecast
            cell.setState(success ? .allGood : .error, forecastCity: element)
            if !success {
                self.showErrorCard(title: "Error loading forecast for \(element.name)", message: errormessage)
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let element =  forecastCities[indexPath.row]
        if element.errorMessage.length > 0 || element.forecast == nil  {
            let alert = UIAlertController(title: "Error: \(element.name)", message: element.errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reload data", style: .default, handler: {
                _ in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "detail", sender: element)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}



class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let refresher = UIRefreshControl()
        refresher.backgroundColor = .clear
        refresher.tintColor = .darkGray
        refresher.addTarget(self, action: #selector(MainViewController.updateData(refr:)), for: .valueChanged)
        self.tableView.addSubview(refresher)
        
//        self.tableView.isScrollEnabled = self.tableView.contentSize.height > (Constants.screenHeight - 65)
    }
    
    func updateData(refr: UIRefreshControl)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            refr.endRefreshing()
            self.tableView.reloadSections([0], with: .automatic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDetailVC,  let forecastCity = sender as? City{
            destinationVC.city = forecastCity
        }
    }

}

