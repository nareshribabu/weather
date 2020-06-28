//
//  ViewController.swift
//  Weather
//  Created by Nareshri Babu on 21/04/2020.
//  Concept by London App Brewery
//  Copyright © 2020 Nareshri Babu. All rights reserved.
//  This app was created for learning purposes.
//  All images were only used for learning purposes and do not belong to me.
//  All sounds were only used for learning purposes and do not belong to me.
//

import UIKit
import CoreLocation //GPS Location

class WeatherViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        //will show popup on the screen asking for permission to use location
        locationManager.requestWhenInUseAuthorization()
        
        //actually grabs the location (using .startUpdatingLocation tracks their location continiously)
        locationManager.requestLocation()
        
        
        
        weatherManager.delegate = self
        
        //textfield should report back to the view controller
        searchTextField.delegate = self
    }
    
 
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    
}

//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate {
    
    //search button is pressed
    @IBAction func searchPressed(_ sender: UIButton) {
        
        //print(searchTextField.text!)
        
        //dismisses the keyboard
        searchTextField.endEditing(true)
        
    }
    
    //the "go" button on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(searchTextField.text!)
        
        //dismisses the keyboard
        searchTextField.endEditing(true)
        
        return true
    }
    
    //decides when the user should stop editing
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type something"
            return false
        }
        
    }
    
    //this will be triggered everytime .endEditing(true) gets run
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        //Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel) {
        
        //need this so that bad network doesnt hang our app (copied from apple documentation)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        if let location = locations.last {
            
            //will allow to activate request location again
            locationManager.stopUpdatingLocation()
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
