//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Jesus Jimenez on 09/06/23.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    var weatherView: WeatherView!
    var weather: Weather? {
        didSet {
            updateUI()
        }
    }
    var city: String = "London" // Default city
    var isCelsius: Bool = true // Default temperature unit (Celsius)


    
    override func loadView() {
        weatherView = WeatherView()
        weatherView.viewController = self
        view = weatherView
        weatherView.cityTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData(for: city)
    }
    
    func fetchWeatherData(for city: String) {
        // Construct the URL with the provided city parameter
        let session = URLSession.shared
        let urlString = "https://api.weatherapi.com/v1/current.json?key=9745357b64764a1c926173930223105&q=\(city)&aqi=no"
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }

        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let location = json["location"] as? [String: Any],
                   let condition = json["current"] as? [String: Any],
                   let conditionText = condition["condition"] as? [String: Any],
                   let text = conditionText["text"] as? String,
                   let localTime = location["localtime"] as? String,
                   let tempCelsius = condition["temp_c"] as? Double,
                   let tempFahrenheit = condition["temp_f"] as? Double {
                    
                    let locationName = location["name"] as? String ?? ""
                    
                    let weather = Weather(locationName: locationName, conditionText: text, temperatureCelsius: tempCelsius, temperatureFahrenheit: tempFahrenheit, localTime: localTime)
                    
                    DispatchQueue.main.async {
                        self?.weather = weather
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

    func updateUI() {
        if let weather = weather {
            weatherView.locationLabel.text = "Location: \(weather.locationName)"
            weatherView.conditionLabel.text = "Condition: \(weather.conditionText)"
            
            if isCelsius {
                weatherView.temperatureLabel.text = "Temperature: \(weather.temperatureCelsius)°C"
            } else {
                weatherView.temperatureLabel.text = "Temperature: \(weather.temperatureFahrenheit)°F"
            }
            
            weatherView.timeLabel.text = "Time: \(weather.localTime)"
            
            // Set the weather image based on the condition
            let weatherImageName: String
            switch weather.conditionText {
            case "Cloudy":
                weatherImageName = "cloudy_image"
            case "Sunny":
                weatherImageName = "sunny_image"
            case "Rainy":
                weatherImageName = "rainy_image"
            case "Partly cloudy":
                weatherImageName = "partly-cloudy-image"
            // Add more cases for other conditions if needed
            default:
                weatherImageName = "default_image"
            }
            
            weatherView.weatherImageView.image = UIImage(named: weatherImageName)
        }
    }
    
    func updateToggleButtonAppearance() {
        let title = isCelsius ? "Toggle to Fahrenheit" : "Toggle to Celsius"
        weatherView.temperatureUnitButton.setTitle(title, for: .normal)
        weatherView.temperatureUnitButton.setTitleColor(.white, for: .normal)
        weatherView.temperatureUnitButton.backgroundColor = isCelsius ? .orange : .darkGray
    }


}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Fetch weather data when the user presses the return key
        if let city = textField.text {
            fetchWeatherData(for: city)
        }
        textField.resignFirstResponder()
        return true
    }
}

