//
//  WeatherCustomCollectionViewCell.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 6/11/23.
//

import UIKit
import SnapKit

class WeatherCustomCollectionViewCell: UICollectionViewCell {
    
    private lazy var weekDay: UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.font = UIFont(name: "Montserrat-Medium", size: 10)
        label.textColor = .black
        return label
    }()
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#D4D4D4").cgColor
        return view
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "snow"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "10° C"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(weekDay)
        contentView.addSubview(cellView)
        cellView.addSubview(weatherImage)
        cellView.addSubview(temperatureLabel)
        
        weekDay.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(weekDay.snp.bottom).offset(6)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(6)
        }
    }
    
    func configureData(weekDay: String, image: String, temp: String) {
        self.weekDay.text = weekDay
        weatherImage.image = UIImage(named: image)
        temperatureLabel.text = temp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
