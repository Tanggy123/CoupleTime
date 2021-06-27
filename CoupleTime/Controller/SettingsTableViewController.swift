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
    var changingMyTZ: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        myTZ.text = defaults.string(forKey: "MyTZ")
        partnerTZ.text = defaults.string(forKey: "PartnerTZ")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changingMyTZ = indexPath.row == 0
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
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
        refresh()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
    func refresh() {
        let defaults = UserDefaults.standard
        myTZ.text = defaults.string(forKey: "MyTZ")
        partnerTZ.text = defaults.string(forKey: "PartnerTZ")
        NotificationCenter.default.post(name: Notification.Name.Action.refreshTime, object: nil)
    }
}

extension Notification.Name {
    struct Action {
        static let refreshTime = Notification.Name("refreshTime")
    }
}
