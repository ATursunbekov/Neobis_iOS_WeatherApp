//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 6/11/23.
//

import Foundation

struct WeatherModel: Codable {
    let list: [WeatherDetail]
    let city: CityDetail
}

struct CityDetail: Codable {
    let name: String
    let country: String
}

struct WeatherDetail: Codable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let pressure: Int
}

struct Weather: Codable {
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

