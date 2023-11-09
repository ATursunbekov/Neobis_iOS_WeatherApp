//
//  DataManager.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 10/11/23.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    var cities: [String] = []
    
    private init() {}
    
    func refreshData() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(cities) {
            UserDefaults.standard.set(encoded, forKey: "cities")
        }
    }
    
    func addCityHistory(city: String) {
        if cities.count > 5 {
            cities.removeLast()
        }
        cities.insert(city, at: 0)
        refreshData()
    }
    
    func getAmount() -> Int{
        return cities.count
    }
    
    func getCity(index: Int) -> String {
        return cities[index]
    }
}
