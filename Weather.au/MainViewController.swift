//
//  ViewController.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit
import ISMessages

//Separation UITableView delagate and dataSourse methods to better code reading

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        let element =  arrayOfCities[indexPath.row]
        cell.setState(.loading)
        cell.fillWith(city: element.city, forecast: nil)
        connectionManager.getWeatherOf(city: element.city, completion: {
            success, errormessage, forecast in
            element.errorMessage = errormessage
            cell.setState(success ? .allGood : .error)
            cell.fillWith(city: element.city, forecast: forecast)
            if !success {
                ISMessages.showCardAlert(withTitle: "Error loading forecast for \(element.city.rawValue)", message: errormessage, duration: 1, hideOnSwipe: true, hideOnTap: true, alertType: .error, alertPosition: .top, didHide: nil)
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let element =  arrayOfCities[indexPath.row]
        if element.errorMessage.length > 0  {
            let alert = UIAlertController(title: "Error: \(element.city.rawValue)", message: element.errorMessage, preferredStyle: .alert)
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
}



class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDetailVC,  let city = sender as? City{
            destinationVC.city = city
        }
    }

}

