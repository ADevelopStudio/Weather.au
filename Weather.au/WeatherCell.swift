//
//  WeatherCell.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit
import ISMessages

class WeatherCell: UITableViewCell {
    enum CellState {
        case loading, error, allGood
    }
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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
    

    func setState(_ state: CellState, forecastCity: City)  {
        loader.isHidden = state != .loading
        self.isUserInteractionEnabled = state == .allGood
        self.accessoryType =  state != .allGood ? .none : .disclosureIndicator
        self.accessoryView = state == .error ? self.errorView : nil
        cityName.text =  forecastCity.name
        temperature.text =  ((forecastCity.forecast != nil && state != .loading) ? forecastCity.forecast!.mainForecastData.currentTemp.degreeCelsius : "")
    }

}
