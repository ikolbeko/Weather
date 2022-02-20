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
    let localNames: LocalNames
    let lat, lon: Double
    let country: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let localNamesIs: String
    let ru, de, en: String

    enum CodingKeys: String, CodingKey {
        case localNamesIs = "is"
        case en, ru, de
    }
}

typealias LocationData = [LocationDatum]

