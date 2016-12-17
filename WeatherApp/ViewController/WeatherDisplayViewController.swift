//
//  WeatherDisplayViewController.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//
//  Weather Display View controller
//  This class is responsible to display/hide weather card operation,
//  Make web request call for weather data and weather icon
//  Show error incase web request fails or user does not enter proper input
//  & stop or start animation for activity indicator

import UIKit

class WeatherDisplayViewController: UIViewController, UITextFieldDelegate
{
    // UI elements
    @IBOutlet weak var cityStateNameTextField: UITextField!
    
    @IBOutlet weak var weatherCardview : WeatehrCardView!
    
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    
    // Network handler to make request for web service calls
    private let netWorkHandler = NetWorkHandler()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.stopActivityIndicator()
        
        self.weatherCardview.hideWeatherUI(true)
        
        if let lastCity = UserDefaults.standard.value(forKey: "lastcity") as? String
        {
            self.cityStateNameTextField.text = lastCity
        }
    }
    
    // Show the weather data from city/state name
    @IBAction func submitBtnPressed(_ sender: Any)
    {
        let cityName = self.cityStateNameTextField.text
        
        // show alert if city/state name is empty
        if cityName == ""
        {
            self.showCityNameAlert(errorMsg: nil)
            self.cityStateNameTextField.resignFirstResponder()
            return
        }
        
        self.showActivityIndicator()
        
        // Make web service request to get the city weather in background
        self.netWorkHandler.fetchCityWeather(cityname: cityName)
        {
            weatherResponse, error in
            
            // Come back to main thread to update UI
            DispatchQueue.main.async
            {
                self.cityStateNameTextField.resignFirstResponder()
                
                self.stopActivityIndicator()

                // in case fail from web call
                if error != nil
                {
                    self.weatherCardview.hideWeatherUI(true)
                    self.showWeatherError()
                }
                
                // success from web call, Display weather data and start async icon image download
                if let weatherResponseData = weatherResponse
                {
                    if (weatherResponseData.errorCode != 200)
                    {
                       if (weatherResponseData.errorMessage != "")
                       {
                            if (weatherResponseData.errorMessage != nil)
                            {
                                self.showCityNameAlert(errorMsg: weatherResponseData.errorMessage)
                            }
                            else
                            {
                                self.showWeatherError()
                            }
                        }
                    }
                    else
                    {
                        self.weatherCardview.displayWeatherDataUI(weatherData: weatherResponseData)
                        
                        // save last city search for next use
                        if let lastCity = weatherResponseData.cityName
                        {
                            UserDefaults.standard.set(lastCity, forKey: "lastcity")
                        }
                        
                        // Start to download icon once we received success in weather data
                        self.downloadImage(weatherData: weatherResponseData)
                    }
                }
            }
        }
    }
    
    // Download weather icon image asynchronosly (in background thread)
    private func downloadImage(weatherData : WeatherDataModel)
    {
        self.netWorkHandler.downloadImage(imageName: weatherData.iconUrl)
        {
            image in
            
            // Come back to main thread
            DispatchQueue.main.async
            {
                // display download icon here
                self.weatherCardview.displayDownloadedIcon(image: image)
            }
        }
    }
    
    // Pop up alert if user does not enter city name and pressed submit button
    private func showCityNameAlert(errorMsg : String?)
    {
        let title = "City Name Missing"
        
        var message = "Please provide proper City name"
        
        
        if errorMsg != nil
        {
            message = errorMsg!
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let dismissActionTitle = "Dismiss"
        
        alertController.addAction(UIAlertAction(title: dismissActionTitle, style: UIAlertActionStyle.default, handler:
        {
                (alert: UIAlertAction!) in
            
            self.cityStateNameTextField.resignFirstResponder()
            self.cityStateNameTextField.text = ""
        }))
        
    
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Display alert if weather web service get any error, here I am showing generic error
    private func showWeatherError()
    {
        let title = "Weather Report Error"
        
        let message = "Please try again after 10 mins"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let dismissActionTitle = "Dismiss"
        
        alertController.addAction(UIAlertAction(title: dismissActionTitle, style: UIAlertActionStyle.default, handler:
            {
                (alert: UIAlertAction!) in
                
                self.cityStateNameTextField.resignFirstResponder()
                self.cityStateNameTextField.text = ""
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // activity indicator ui stop animation and hide it
    private func stopActivityIndicator()
    {
        self.acitivityIndicator.isHidden = true
        self.acitivityIndicator.stopAnimating()
    }
    
    // activity indicator ui start animation and show it
    private func showActivityIndicator()
    {
        self.acitivityIndicator.isHidden = true
        self.acitivityIndicator.startAnimating()
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
//        
//        return string.rangeOfCharacter(from: set) == nil
//        
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
        
        return string.rangeOfCharacter(from: set) == nil
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

