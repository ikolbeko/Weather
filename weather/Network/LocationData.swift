//
//  LocationData.swift
//  weather
//
//  Created by Илья Колбеко on 20.02.22.
//

import Foundation

// MARK: - LocationDatum
struct LocationDatum: Codable {
    let name: String
    let localNames: [String: String]
    let lat, lon: Double
    let country: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country
    }
}

typealias LocationData = [LocationDatum]
