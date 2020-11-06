//
//  OnboardingViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/23/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import Foundation
import UIKit
import TimeZonePicker

class OnboardingViewController: UIViewController, TimeZonePickerDelegate {
    
    @IBOutlet weak var timeZoneName: UILabel!
    @IBOutlet weak var timeZoneOffset: UILabel!
    @IBOutlet weak var nameField: UnderlineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (nameField != nil) {
            nameField.attributedPlaceholder =
            NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBAction func addCityTapped(_ sender: UIButton) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        timeZoneName.text = timeZone.identifier
        timeZoneOffset.text = timeZone.abbreviation()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextView(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "TZ") == nil {
            defaults.set(timeZoneName.text, forKey: "TZ")
        } else if defaults.string(forKey: "PartnerTZ") == nil {
            defaults.set(timeZoneName.text, forKey: "PartnerTZ")
        } else {
            defaults.set(nameField.text, forKey: "PartnerName")
        }
        performSegue(withIdentifier: "nextSetting", sender: nil)
    }
}
