//
//  WeatherDetailVC.swift
//  Weather.au
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    var city: City?
    
    override func viewDidLoad() {
     super.viewDidLoad()
     if city == nil {
        self.showErrorCard(title: "Error", message: "Data was loaded incorrectly")
        _ = self.navigationController?.popViewController(animated: true)
        return
     }
        title = city!.name
    }
}
