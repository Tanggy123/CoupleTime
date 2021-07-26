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
    @IBOutlet weak var con: UIButton!
    @IBOutlet weak var instruction: UILabel!
    
    // Latitude and longitude info for solar
    var userLat: Double = 0.0
    var userLng: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Formatting
        instruction.adjustsFontSizeToFitWidth = true
        con.isHidden = true
        
        // For partner name onboarding page
        if (nameField != nil) {
            nameField.attributedPlaceholder =
            NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            nameField.delegate = self
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tap) // Add tap gesture recognizer to background view
            con.isHidden = false
        }
    }
    
    @objc func handleTap() {
        nameField.resignFirstResponder() // dismiss keyoard
    }
    
    @IBAction func addCityTapped(_ sender: UIButton) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone, _ lat: Double, _ lng: Double) {
        timeZoneName.text = timeZone.identifier
        timeZoneOffset.text = timeZone.abbreviation()
        userLat = lat
        userLng = lng
        con.isHidden = false
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextView(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "MyTZ") == nil {
            defaults.set(timeZoneName.text, forKey: "MyTZ")
            defaults.set(userLat, forKey: "MyLat")
            defaults.set(userLng, forKey: "MyLng")
        } else if defaults.string(forKey: "PartnerTZ") == nil {
            defaults.set(timeZoneName.text, forKey: "PartnerTZ")
            defaults.set(userLat, forKey: "PartnerLat")
            defaults.set(userLng, forKey: "PartnerLng")
        } else {
            defaults.set(nameField.text, forKey: "PartnerName")
            // Make sure onboarding screen will not launch again
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        }
        performSegue(withIdentifier: "nextSetting", sender: nil)
    }
}

extension OnboardingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
