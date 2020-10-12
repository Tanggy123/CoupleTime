//
//  ViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/18/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTime();
        // Do any additional setup after loading the view.
    }
    
    func setTime() {
        guard let tz: TimeZone = TimeZone.init(identifier: "America/Los_Angeles") else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = tz
        
        //Display time and date
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        timeLabel.text = dateFormatter.string(from: Date())
        
        dateFormatter.dateFormat = "EEE, MMM d"
        dateLabel.text = dateFormatter.string(from: Date())
    }

}

