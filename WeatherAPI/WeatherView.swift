//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by Jesus Jimenez on 09/06/23.
//

import Foundation
import UIKit

class WeatherView: UIView {
    
    weak var viewController: WeatherViewController? // Add this property
    
    let locationLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textAlignment = .center
            return label
        }()
        
    let conditionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            return label
        }()
    
    let temperatureLabel: UILabel = { // Add this property
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .center
            return label
        }()
        
    let timeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .center
            return label
        }()
    // Add a toggle button to WeatherView
    let temperatureUnitButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Toggle Unit", for: .normal)
        button.addTarget(self, action: #selector(toggleTemperatureUnit), for: .touchUpInside)
        return button
        
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter city"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "weather_background")
        return imageView
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        //backgroundColor = .white
        addSubview(backgroundImage)
        addSubview(weatherImageView)
        addSubview(locationLabel)
        addSubview(conditionLabel)
        addSubview(temperatureLabel)
        addSubview(timeLabel)
        addSubview(temperatureUnitButton) // Add this line
        addSubview(cityTextField)

        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70),
            
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            
            temperatureUnitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureUnitButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 16),
            
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: conditionLabel.topAnchor, constant: -16),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100),
            
            cityTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }


    // Add the toggleTemperatureUnit() method to WeatherViewController
    @objc func toggleTemperatureUnit() {
        viewController?.isCelsius.toggle()
        viewController?.updateUI()
        viewController?.updateToggleButtonAppearance()

    }
}
