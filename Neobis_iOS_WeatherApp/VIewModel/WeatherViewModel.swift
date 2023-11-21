//
//  WeatherViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 20/11/23.
//

import Foundation

protocol WeatherViewModelProtocol {
    var weekWeather: [WeekWeatherModel] { get set }
    var dataManager: DataManager { get set }
    
    var configureFetchedData: ((WeatherModel) -> Void)? { get set }
    var setCountryName: (([CountryModel]) -> Void)? { get set }
    
    func convertDateString(_ dateString: String) -> String
    func getHighestTemp(model: WeatherModel) -> Void
    func makeRequest(cityName: String)
    func getCountryName(shortName: String)
}

class WeatherViewModel: WeatherViewModelProtocol {
    var weekWeather: [WeekWeatherModel] = []
    var dataManager = DataManager.shared
    var configureFetchedData: ((WeatherModel) -> Void)?
    var setCountryName: (([CountryModel]) -> Void)?
    
    func makeRequest(cityName: String) {
        WeatherService.manager.getData(city: cityName) { weatherModel in
            self.configureFetchedData?(weatherModel)
        }
    }
    
    func getCountryName(shortName: String) {
        WeatherService.manager.getCountryName(shortName: shortName) { model in
            self.setCountryName?(model)
        }
    }
    
    func getHighestTemp(model: WeatherModel) {
        var separatedWeather: [String: [WeatherDetail]] = [:]
            
            for weatherDetail in model.list {
                let dateString = String(weatherDetail.dt_txt.prefix(10))
                    if separatedWeather[dateString] != nil {
                        separatedWeather[dateString]?.append(weatherDetail)
                    } else {
                        separatedWeather[dateString] = [weatherDetail]
                    }
            }
        
        let sortedDates = separatedWeather.keys.sorted()
        var index = 0
        weekWeather.removeAll()
        for date in sortedDates {
            if let weatherDetails = separatedWeather[date], let maxTemp = weatherDetails.map({ $0.main.temp }).max() {
                if let maxTempDetail = weatherDetails.first(where: { $0.main.temp == maxTemp }) {
                    if index != 0 {
                        let dayOfWeek = dayOfWeek(from: date)
                        weekWeather.append(WeekWeatherModel(temp: Int(round(maxTempDetail.main.temp)), image: maxTempDetail.weather[0].icon, weekDay: dayOfWeek ?? "Monday"))
                    }
                    index += 1
                }
            }
        }
        print(weekWeather)
    }
    
    func convertDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy"
        
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "d"
            let day = dayFormatter.string(from: date)
            let ordinalSuffix: String
            
            switch day {
            case "1", "21", "31":
                ordinalSuffix = "st"
            case "2", "22":
                ordinalSuffix = "nd"
            case "3", "23":
                ordinalSuffix = "rd"
            default:
                ordinalSuffix = "th"
            }
            
            formatter.dateFormat = "MMMM d'\(ordinalSuffix)', yyyy"
            return formatter.string(from: date)
        }
        
        return "Invalid Date"
    }
    
    func dayOfWeek(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date)
            let standaloneWeekdaySymbols = calendar.standaloneWeekdaySymbols
            return standaloneWeekdaySymbols[dayOfWeek - 1]
        }
        return nil
    }
}
