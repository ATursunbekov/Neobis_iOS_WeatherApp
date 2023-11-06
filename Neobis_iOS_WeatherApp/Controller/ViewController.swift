//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 2/11/23.
//

import UIKit

class ViewController: UIViewController {

    let weatherView = WeatherView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(weatherView)
        setupTargets()
    }

    func setupTargets() {
        weatherView.searchButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
        weatherView.closeButton.addTarget(self, action: #selector(searchToggle), for: .touchUpInside)
    }
    
    @objc func searchToggle() {
        weatherView.mainView.isHidden = !weatherView.mainView.isHidden
        weatherView.searchView.isHidden = !weatherView.searchView.isHidden
    }
}

