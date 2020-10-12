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
    @IBOutlet weak var underlineTextField: UnderlineTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (underlineTextField != nil) {
            underlineTextField.attributedPlaceholder =
            NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? SearchCityViewController {
//            vc.delegate = self
//        }
//    }
    
    @IBAction func addCityTapped(_ sender: UIButton) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        timeZoneName.text = timeZone.identifier
        timeZoneOffset.text = timeZone.abbreviation()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
}
