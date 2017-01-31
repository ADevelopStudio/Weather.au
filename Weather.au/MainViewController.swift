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
        return arrayOfCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        let element =  arrayOfCities[indexPath.row]
        cell.fillWith(city: element.city, completion:  {
            errorMessage in
            element.errorMessage = errorMessage
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

}

