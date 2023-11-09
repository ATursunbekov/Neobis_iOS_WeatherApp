//
//  CountryModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 9/11/23.
//

import Foundation

struct CountryModel: Codable {
    let name: NameModel
}

struct NameModel: Codable {
    let common: String
}
