//
//  timeZoneNames.swift
//  CoupleTime
//
//  Created by Jimmy Tang on 7/18/20.
//  Copyright © 2020 James Tang. All rights reserved.
//

import Foundation

class timeZoneData {
    let timeZoneIDs = TimeZone.knownTimeZoneIdentifiers
    var timeZoneCityNames : [String]!
    
    init() {
        timeZoneCityNames = timeZoneIDs.map {(s1: String) -> String in
//            let continent = s1.split(separator: "/")[0]
//            let city = s1.split(separator: "/")[1]
//            return city + ", " + continent
            return s1
        }
    }
    
}
