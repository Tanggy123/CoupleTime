//
//  PartnerSettingsViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 7/3/21.
//  Copyright © 2021 James Tang. All rights reserved.
//

import Foundation
import UIKit

class PartnerSettingsViewController: UIViewController {
    
    @IBOutlet weak var partnerNameField: UnderlineTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        partnerNameField.text = defaults.string(forKey: "PartnerName")
    }
    
    @IBAction func save(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(partnerNameField.text, forKey: "PartnerName")
        NotificationCenter.default.post(name: Notification.Name.Action2.refreshSettings, object: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension Notification.Name {
    struct Action2 {
        static let refreshSettings = Notification.Name("refreshSettings")
    }
}
