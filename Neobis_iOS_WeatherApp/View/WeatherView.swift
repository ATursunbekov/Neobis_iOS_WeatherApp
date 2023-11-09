//
//  WeatherView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 2/11/23.
//

import Foundation
import UIKit
import SnapKit

class WeatherView: UIView {
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var dateText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var cityName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Bold", size: 40)
        label.textColor = .white
        return label
    }()
    
    lazy var countryName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var circleView: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 120
        circleView.layer.shadowColor = UIColor(hex: "#30A2C5").cgColor
        circleView.layer.shadowOffset = CGSize(width: 0, height: 20)
        circleView.layer.shadowRadius = 20
        circleView.layer.shadowOpacity = 1
        return circleView
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var tempretureText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Light", size: 90)
        return label
    }()
    
    lazy var infoView1 = UIView()
    lazy var infoView2 = UIView()
    
    lazy var windStatus: UILabel = {
        let label = UILabel()
        label.text = "Wind status"
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var windStatusData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var humidity: UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var humidityData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var visibility: UILabel = {
        let label = UILabel()
        label.text = "Visibility"
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var visibilityData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var airPressure: UILabel = {
        let label = UILabel()
        label.text = "Air pressure"
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    lazy var airPressureData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Montserrat-Regular", size: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var weekView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 60
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.text = "The Next 5 days"
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.textColor = .black
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9
        layout.itemSize = CGSize(width: dynamicW(70), height: dynamicH(93))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherCustomCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "close"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(hex: "#30A2C5").cgColor, UIColor(hex: "#00242F", alpha: 0.8).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }()
    
    lazy var searchFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.backgroundColor = UIColor(hex: "#EDEDED")
        return view
    }()
    
    let searchTextField: UITextField = {
            let textField = UITextField()
            let attributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 16)
                ]
            textField.attributedPlaceholder = NSAttributedString(string: "SEARCH LOCATION", attributes: attributes)
            textField.textAlignment = .left
            return textField
    }()
    
    lazy var searchCityButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var mainView = UIView()
    
    lazy var tableView:UITableView = {
        let  tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        tableView.register(WeatherCustomTableViewCell.self, forCellReuseIdentifier: "weatherTableViewCell")
        tableView.rowHeight = 30
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.addSublayer(gradientLayer)
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(mainView)
        mainView.addSubview(searchButton)
        mainView.addSubview(dateText)
        mainView.addSubview(cityName)
        mainView.addSubview(countryName)
        mainView.addSubview(circleView)
        circleView.addSubview(weatherImage)
        circleView.addSubview(tempretureText)
        mainView.addSubview(infoView1)
        mainView.addSubview(infoView2)
        infoView1.addSubview(windStatus)
        infoView1.addSubview(windStatusData)
        infoView1.addSubview(humidity)
        infoView1.addSubview(humidityData)
        infoView2.addSubview(visibility)
        infoView2.addSubview(visibilityData)
        infoView2.addSubview(airPressure)
        infoView2.addSubview(airPressureData)
        mainView.addSubview(weekView)
        weekView.addSubview(weekLabel)
        weekView.addSubview(collectionView)
        addSubview(searchView)
        searchView.addSubview(closeButton)
        searchView.addSubview(searchFieldView)
        searchFieldView.addSubview(searchTextField)
        searchFieldView.addSubview(searchCityButton)
        searchView.addSubview(tableView)
        
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(25)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        dateText.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.centerX.equalToSuperview()
        }
        
        cityName.snp.makeConstraints { make in
            make.top.equalTo(dateText.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        countryName.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(countryName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(240)
            make.width.equalTo(240)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)//75
            make.width.equalTo(90)//75
        }
        
        tempretureText.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        infoView1.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(31)
            make.centerX.equalToSuperview().offset(UIScreen.main.bounds.width / -4)
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        
        infoView2.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(31)
            make.centerX.equalToSuperview().offset(UIScreen.main.bounds.width / 4)
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        
        windStatus.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        windStatusData.snp.makeConstraints { make in
            make.top.equalTo(windStatus.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        humidity.snp.makeConstraints { make in
            make.top.equalTo(windStatusData.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        
        humidityData.snp.makeConstraints { make in
            make.top.equalTo(humidity.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        visibility.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        visibilityData.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(visibility.snp.bottom).offset(10)
        }
        
        airPressure.snp.makeConstraints { make in
            make.top.equalTo(visibilityData.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
        }
        
        airPressureData.snp.makeConstraints { make in
            make.top.equalTo(airPressure.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        weekView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(infoView1.snp.bottom).offset(30)
        }
        
        weekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(51)
            make.leading.equalToSuperview().offset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(95)
            make.top.equalTo(weekLabel.snp.bottom).offset(16)
        }
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(366)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        searchFieldView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(54)
            make.trailing.equalToSuperview().offset(-54)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(63)
            make.trailing.equalToSuperview().offset(-63)
            make.bottom.equalToSuperview()
        }
        
        searchCityButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalTo(searchCityButton).offset(-5)
        }
        
        searchView.isHidden = true
    }
    
    private func dynamicH(_ height: Double) -> Double{
        return UIScreen.main.bounds.height * height / 896
    }
    
    private func dynamicW(_ width: Double) -> Double {
        return UIScreen.main.bounds.width * width / 414
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
