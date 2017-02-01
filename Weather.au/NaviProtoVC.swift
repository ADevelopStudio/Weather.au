//
//  NaviProtoVC.swift
//  Profies
//
//  Created by Dmitrii Zverev on 31/1/17.
//  Copyright © 2017 Dmitrii Zverev. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func applySettings()  {
        let backImage = UIImage(named: "black60percent")
        self.setBackgroundImage(backImage, for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.tintColor = UIColor.white
        let titleDict: [String : AnyObject] = [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: 0.1), NSForegroundColorAttributeName: UIColor.white]
        self.titleTextAttributes = titleDict
    }
    
}

class MyNavBar: UINavigationBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.applySettings()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.applySettings()
    }

}


class NaviProtoVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.applySettings()
    }
}
