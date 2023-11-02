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
        view.addSubview(weatherView)
    }


}

