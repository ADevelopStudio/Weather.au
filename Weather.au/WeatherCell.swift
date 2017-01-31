//
//  WeatherCell.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    var loadingErrorMessage: String = ""
    var city: Constants.City?
    
    var errorView: UIImageView {
        let error = UIImageView(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        error.image = UIImage(named: "errorLoading")
        return error
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityName.text = ""
        temperature.text = ""
        loader.isHidden = false
    }
    
    
    
    func fillWith(city:  Constants.City,   completion: @escaping(_ error: String) -> ()) {
        self.isUserInteractionEnabled = false
        self.city = city
        cityName.text = city.rawValue
        loader.isHidden = false
        temperature.text = ""
        self.accessoryType = .none
        self.accessoryView = nil
        connectionManager.getWeatherOf(city: .brisbane, completion: {
            success, errorMessage in
            self.loader.isHidden = true
            self.isUserInteractionEnabled = true
            self.loadingErrorMessage = errorMessage
            if !success {
                 self.accessoryView = self.errorView
            } else {
                self.accessoryType = .disclosureIndicator
            }
            completion(errorMessage)
        })
    }
}
