//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTxtField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTxtField.returnKeyType = .go
        weatherManager.delegate = self
    }

    @IBAction func searchBtnTap(_ sender: UIButton) {
        print(searchTxtField.text ?? "")
        searchTxtField.endEditing(true)
    }
    
    @IBAction func currentLocationBtnTap(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UITtextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        return searchTxtField.endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTxtField.text  {
            weatherManager.fetchWeather(cityName: city, longitude: 0.0 , latitute: 0.0)
        }
        searchTxtField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
      if  textField.text != "" {
           return true
      } else {
          textField.placeholder = "type something..."
          return false
      }
    }
    
}

// MARK: - WeatherUpdate delegate
extension WeatherViewController : WeatherManagerProtocol {
    func didupdateWithError(error: Error) {
        print(error)
    }
    
    func didupdateWeather(weatherModel: WeatherModel) {
        print(weatherModel.temperature)
        DispatchQueue.main.async {
            self.conditionImageView.image =  UIImage(systemName: weatherModel.conditionName)
            self.cityLabel.text =  weatherModel.name
            self.temperatureLabel.text =  weatherModel.temperatureProperty
        }
    }
}


// MARK: - Get user current location

extension WeatherViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got locaiton")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lag = location.coordinate.longitude
            print(lag,lat)
            weatherManager.fetchWeather(cityName: "", longitude: lag, latitute: lat)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error",error)
    }
}
