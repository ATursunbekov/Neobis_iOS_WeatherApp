//
//  WeatherService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 8/11/23.
//

import Foundation

class WeatherService {
    static let manager = WeatherService()
    
    func getData(city: String, completion: @escaping (WeatherModel) -> ()) {
        let BASE_URL =  "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=2856fc05d4d4ec7e2819cbe23c320845&units=metric"
        
        guard let url = URL(string: BASE_URL) else {
            fatalError("Wrond City name")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error with data!")
                return
            }
            
            var resultData: WeatherModel?
            
            do {
                resultData = try JSONDecoder().decode(WeatherModel.self, from: data)
            } catch {
                print("Failed to decode data!")
            }
            
            guard let final = resultData else {
                return
            }
            completion(final)
        }
        task.resume()
    }
    
    func getCountryName(shortName: String, completion: @escaping ([CountryModel]) -> ()) {
        let BASE_URL =  "https://restcountries.com/v3.1/alpha/\(shortName)"
        
        guard let url = URL(string: BASE_URL) else {
            fatalError("Wrond Country name")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error with data!")
                return
            }
            
            var resultData: [CountryModel]?
            
            do {
                resultData = try JSONDecoder().decode([CountryModel].self, from: data)
            } catch {
                print("Failed to decode data!")
            }
            
            guard let final = resultData else {
                return
            }
            completion(final)
        }
        task.resume()
    }
}
