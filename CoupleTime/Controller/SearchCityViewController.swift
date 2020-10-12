//
//  SearchCityViewController.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 5/25/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import Foundation
import UIKit

class SearchCityViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var allCityName : [String] = []
    var cityNames: [String] = []
    var delegate: OnboardingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        let tzData = timeZoneData()
        allCityName = tzData.timeZoneCityNames
        cityNames = allCityName
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = cityNames[indexPath.row]
        return cell
    }
    
    // Update table according to inputs in searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cityNames = searchText.isEmpty ? allCityName : allCityName.filter { (id: String) -> Bool in
            return id.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}
