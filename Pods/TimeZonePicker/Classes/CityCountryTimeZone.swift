//
//  CityCountryTimeZone.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import Foundation

struct CityCountryTimeZone: Codable {

    let city: String
    let country: String
    let timeZoneName: String
    let lat: Double
    let lng: Double

    init(city: String, country: String, timeZoneName: String, lat: Double, lng: Double) {
        self.city = city
        self.country = country
        self.timeZoneName = timeZoneName
        self.lat = lat
        self.lng = lng
    }

    func contains(_ string: String) -> Bool {
        return city.lowercased().contains(string.lowercased()) || country.lowercased().contains(string.lowercased())
    }

    func string() -> String {
        if country.isEmpty {
            return city
        }
        return "\(city), \(country)"
    }

}

extension CityCountryTimeZone: Equatable, Comparable {

    static func ==(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city == rhs.city && lhs.country == rhs.country && lhs.timeZoneName == rhs.timeZoneName
    }

    static func <(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city < rhs.city
    }

    static func <=(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city <= rhs.city
    }

    static func >=(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city >= rhs.city
    }

    static func >(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city > rhs.city
    }

}
