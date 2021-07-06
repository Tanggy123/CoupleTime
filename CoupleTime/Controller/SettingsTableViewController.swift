//
//  SettingsTableViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 6/18/21.
//  Copyright © 2021 James Tang. All rights reserved.
//

import Foundation
import UIKit
import TimeZonePicker

class SettingsTableViewController: UITableViewController, TimeZonePickerDelegate {
    
    @IBOutlet weak var myTZ: UILabel!
    @IBOutlet weak var partnerTZ: UILabel!
    @IBOutlet weak var partnerName: UILabel!
    var changingMyTZ: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        myTZ.text = defaults.string(forKey: "MyTZ")
        partnerTZ.text = defaults.string(forKey: "PartnerTZ")
        partnerName.text = defaults.string(forKey: "PartnerName")
        
        /* Listens for partner name change*/
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSettings), name: Notification.Name.Action2.refreshSettings, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            changingMyTZ = indexPath.row == 0
            let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
            present(timeZonePicker, animated: true, completion: nil)
        } else if (indexPath.section == 1) {
            performSegue(withIdentifier: "setPartnerName", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone, _ lat: Double, _ lng: Double) {
        let defaults = UserDefaults.standard
        if changingMyTZ {
            defaults.set(timeZone.identifier, forKey: "MyTZ")
            defaults.set(lat, forKey: "MyLat")
            defaults.set(lng, forKey: "MyLng")
        } else {
            defaults.set(timeZone.identifier, forKey: "PartnerTZ")
            defaults.set(lat, forKey: "PartnerLat")
            defaults.set(lng, forKey: "PartnerLng")
        }
        refreshSettings()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
    /* Refresh settings page and send noti to update TimeViewController. */
    @objc func refreshSettings() {
        let defaults = UserDefaults.standard
        myTZ.text = defaults.string(forKey: "MyTZ")
        partnerTZ.text = defaults.string(forKey: "PartnerTZ")
        partnerName.text = defaults.string(forKey: "PartnerName")
        NotificationCenter.default.post(name: Notification.Name.Action1.refreshTime, object: nil)
    }
}

extension Notification.Name {
    struct Action1 {
        static let refreshTime = Notification.Name("refreshTime")
    }
}
