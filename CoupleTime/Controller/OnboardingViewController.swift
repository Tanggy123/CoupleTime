//
//  OnboardingViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/23/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var underlineTextField: UnderlineTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (underlineTextField != nil) {
            underlineTextField.attributedPlaceholder =
            NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(underlineTextField.text, forKey: "name")
        performSegue(withIdentifier: "onboardToMainSegue", sender: self)
    }
    
    @IBAction func addCityTapped(_ sender: UIButton) {
        
    }
}
