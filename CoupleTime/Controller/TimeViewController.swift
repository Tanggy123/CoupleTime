//
//  ViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/18/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import UIKit
import CoreLocation
import Solar

class TimeViewController: UIViewController {

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myTimeLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnerTimeLabel: UILabel!
    @IBOutlet weak var partnerDateLabel: UILabel!
    @IBOutlet weak var myBackground: UIImageView!
    @IBOutlet weak var partnerBackground: UIImageView!
    
    var timer: Timer! = Timer()
    var backgroundTimer: Timer! = Timer()
    
    let dayTextColor = UIColor.black
    let nightTextColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTime()
        setBackground()
        setPartnerName()
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        backgroundTimer = Timer.scheduledTimer(timeInterval: 1800, target: self, selector: #selector(setBackground), userInfo: nil, repeats: true)
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
        
        //Set my time and date
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
    
    @objc func setBackground() {
        let defaults = UserDefaults.standard
        
        // Get location info
        let myLat = defaults.double(forKey: "MyLat")
        let myLng = defaults.double(forKey: "MyLng")
        let partnerLat = defaults.double(forKey: "PartnerLat")
        let partnerLng = defaults.double(forKey: "PartnerLng")
        guard let mySolar = Solar(coordinate: CLLocationCoordinate2D(latitude: myLat, longitude: myLng)) else {return}
        guard let partnerSolar = Solar(coordinate: CLLocationCoordinate2D(latitude: partnerLat, longitude: partnerLng)) else {return}
        
        // Set background
        if mySolar.isDaytime {
            myBackground.image = UIImage(named: "day")
            setMyFont(dayTextColor)
        } else {
            myBackground.image = UIImage(named: "night")
            setMyFont(nightTextColor)
        }
        if partnerSolar.isDaytime {
            partnerBackground.image = UIImage(named: "day")
            setPartnerFont(dayTextColor)
        } else {
            partnerBackground.image = UIImage(named: "night")
            setPartnerFont(nightTextColor)
        }
        partnerBackground.image = partnerSolar.isDaytime ? UIImage(named: "day") : UIImage(named: "night")
    }
    
    func setMyFont(_ color: UIColor) {
        myName.textColor = color
        myTimeLabel.textColor = color
        myDateLabel.textColor = color
    }
    
    func setPartnerFont(_ color: UIColor) {
        partnerName.textColor = color
        partnerTimeLabel.textColor = color
        partnerDateLabel.textColor = color
    }
    
    func setPartnerName() {
        guard let name = UserDefaults.standard.string(forKey: "PartnerName") else {return}
        partnerName.adjustsFontSizeToFitWidth = true
        partnerName.text = name
    }

}
