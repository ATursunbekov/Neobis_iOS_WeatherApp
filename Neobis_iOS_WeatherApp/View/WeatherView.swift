//
//  WeatherView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alikhan Tursunbekov on 2/11/23.
//

import Foundation
import UIKit

class WeatherView: UIView {
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(hex: "#30A2C5").cgColor, UIColor(hex: "#00242F").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
