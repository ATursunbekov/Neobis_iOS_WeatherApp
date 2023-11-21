//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 2/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: WeatherViewModelProtocol!

    let weatherView = WeatherView(frame: UIScreen.main.bounds)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = WeatherViewModel()
        setupComplitionHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(weatherView)
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.tableView.delegate = self
        weatherView.tableView.dataSource = self
        setupTargets()
        viewModel.makeRequest(cityName: "Bishkek")
    }
    
    @objc func searchToggle() {
        weatherView.mainView.isHidden = !weatherView.mainView.isHidden
        weatherView.searchView.isHidden = !weatherView.searchView.isHidden
    }
    
    @objc func searchPressed() {
        guard let searchingCity = weatherView.searchTextField.text, !searchingCity.isEmpty else{return}
        viewModel.makeRequest(cityName: searchingCity)
        viewModel.dataManager.addCityHistory(city: searchingCity)
        weatherView.tableView.reloadData()
        searchToggle()
    }
    
    func setupTargets() {
        weatherView.searchButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
        weatherView.closeButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
        weatherView.searchCityButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    }
    
    func setupComplitionHandlers() {
        viewModel.configureFetchedData = { [weak self] response in
            self?.fetchData(weatherModel: response)
        }
        viewModel.setCountryName = { [weak self] models in
            DispatchQueue.main.async {
                self?.weatherView.countryName.text = models[0].name.common
            }
        }
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
            self.weatherView.dateText.text = self.viewModel.convertDateString(weatherModel.list[1].dt_txt)
            self.viewModel.getHighestTemp(model: weatherModel)
            self.weatherView.collectionView.reloadData()
        }
        viewModel.getCountryName(shortName: weatherModel.city.country)
    }
}

//UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weekWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCustomCollectionViewCell
        let temp = viewModel.weekWeather[indexPath.row]
        cell.configureData(weekDay: temp.weekDay, image: temp.image, temp: "\(temp.temp) °C")
        return cell
    }
}

//UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataManager.getAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! WeatherCustomTableViewCell
        cell.configureData(cityName: viewModel.dataManager.getCity(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherView.searchTextField.text = viewModel.dataManager.getCity(index: indexPath.row)
    }
}
