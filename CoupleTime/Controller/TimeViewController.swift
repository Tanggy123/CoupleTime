//
//  ViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/18/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    @IBOutlet weak var myTimeLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnerTimeLabel: UILabel!
    @IBOutlet weak var partnerDateLabel: UILabel!
    @IBOutlet weak var myBackground: UIImageView!
    @IBOutlet weak var partnerBackground: UIImageView!
    
    
//    var myBackground: UIImage? = UIImage(named: "morning.png")
//    var myPartnerBackground: UIImage? = UIImage(named: "morning.png")
    var timer: Timer! = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTime()
        setPartnerName()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
    }
    
    @objc func setTime() {
        let defaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        
        //Retrieve time zone info
        guard let myTimeZoneId = defaults.string(forKey: "TZ") else {return}
        guard let partnerTimeZoneId = defaults.string(forKey: "PartnerTZ") else {return}
        guard let myTZ: TimeZone = TimeZone.init(identifier: myTimeZoneId) else {return}
        guard let partnerTZ = TimeZone.init(identifier: partnerTimeZoneId) else {return}
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Get location info

        
        //Set my time
        dateFormatter.timeZone = myTZ
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        myTimeLabel.text = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "EEE, MMM d"
        myDateLabel.text = dateFormatter.string(from: Date())
        
        //Set partner time and date
        dateFormatter.timeZone = partnerTZ
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        partnerTimeLabel.text = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "EEE, MMM d"
        partnerDateLabel.text = dateFormatter.string(from: Date())
    }
    
    func setPartnerName() {
        guard let name = UserDefaults.standard.string(forKey: "PartnerName") else {return}
        partnerName.adjustsFontSizeToFitWidth = true
        partnerName.text = name
    }

}
