//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 2/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var weekWeather: [WeekWeatherModel] = []
    
    var dataManager = DataManager.shared

    let weatherView = WeatherView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(weatherView)
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.tableView.delegate = self
        weatherView.tableView.dataSource = self
        setupTargets()
        WeatherService.manager.getData(city: "Bishkek") { weatherModel in
            self.fetchData(weatherModel: weatherModel)
        }
    }
    
    func setupTargets() {
        weatherView.searchButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
        weatherView.closeButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
        weatherView.searchCityButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    }
    
    @objc func searchToggle() {
        weatherView.mainView.isHidden = !weatherView.mainView.isHidden
        weatherView.searchView.isHidden = !weatherView.searchView.isHidden
    }
    
    @objc func searchPressed() {
        guard let searchingCity = weatherView.searchTextField.text, !searchingCity.isEmpty else{return}
        WeatherService.manager.getData(city: searchingCity) { weatherModel in
            self.fetchData(weatherModel: weatherModel)
        }
        dataManager.addCityHistory(city: searchingCity)
        weatherView.tableView.reloadData()
        searchToggle()
    }
    
    func fetchData(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.tempretureText.text = "\(Int(round(weatherModel.list[1].main.temp)))°C"
            self.weatherView.humidityData.text = "\(weatherModel.list[1].main.humidity)%"
            self.weatherView.airPressureData.text = "\(weatherModel.list[1].main.pressure) mb"
            self.weatherView.windStatusData.text = "\(Int(round(weatherModel.list[1].wind.speed))) mph"
            self.weatherView.visibilityData.text = "\(String(format: "%.1f",(Double(weatherModel.list[1].visibility) / 1609.0))) miles"
            self.weatherView.weatherImage.image = UIImage(named: weatherModel.list[1].weather[0].icon)
            self.weatherView.cityName.text = weatherModel.city.name
            self.weatherView.dateText.text = self.convertDateString(weatherModel.list[1].dt_txt)
            self.getHighestTemp(model: weatherModel)
        }
        WeatherService.manager.getCountryName(shortName: weatherModel.city.country) { model in
            DispatchQueue.main.async {
                self.weatherView.countryName.text = model[0].name.common
            }
        }
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
        weatherView.collectionView.reloadData()
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCustomCollectionViewCell
        let temp = weekWeather[indexPath.row]
        cell.configureData(weekDay: temp.weekDay, image: temp.image, temp: "\(temp.temp) °C")
        return cell
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! WeatherCustomTableViewCell
        cell.configureData(cityName: dataManager.getCity(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherView.searchTextField.text = dataManager.getCity(index: indexPath.row)
    }
}
