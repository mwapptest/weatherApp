//
//  ViewController.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityStateNameTextField: UITextField!
    
    @IBOutlet weak var minMaxTemprature: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var temprature: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    
    private let netWorkHandler = NetWorkHandler()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.acitivityIndicator.isHidden = true
        self.acitivityIndicator.stopAnimating()
        self.hideWeatherUI(true)
        
    }
    
    @IBAction func submitBtnPressed(_ sender: Any)
    {
        let cityName = self.cityStateNameTextField.text
        
        if cityName == ""
        {
            // show alert
            return
        }
        
        self.acitivityIndicator.isHidden = false
        
        self.acitivityIndicator.startAnimating()
        
        self.netWorkHandler.fetchCityWeather(cityname: cityName)
        {
            weatherResponse, error in
            
            DispatchQueue.main.async
            {
                self.acitivityIndicator.isHidden = true
                self.acitivityIndicator.stopAnimating()

                if error != nil
                {
                    self.hideWeatherUI(true)
                }
                print("dictionary \(weatherResponse)")
                
                if let weatherResponseData = weatherResponse
                {
                    self.displayWeatherDataUI(weatherData: weatherResponseData)
                }
            }
        }
    }
    
    private func displayWeatherDataUI(weatherData: WeatherDataModel)
    {
        self.hideWeatherUI(false)
        
        self.descriptionLbl.text = weatherData.description
        
        self.temprature.text = String(format:"%0.0fº",self.tempratureInC(weatherData.temperature!))
        
        self.minMaxTemprature.text = String(format:"Min / Max:   %.1fº / %.1fº",self.tempratureInC(weatherData.maxTemp!),self.tempratureInC(weatherData.minTemp!))
        
        netWorkHandler.downloadImage(imageName: weatherData.iconUrl)
        {
            image in
            
            if image != nil
            {
                DispatchQueue.main.async
                {
                    self.iconImage.isHidden = false
                    self.iconImage.image = image
                }
            }
            else
            {
                self.iconImage.isHidden = true
            }
        }
    }
    
    private func hideWeatherUI(_ isRequiredToHide: Bool)
    {
        if isRequiredToHide
        {
            self.cityStateNameTextField.text = ""
        }
        
        self.iconImage.isHidden = isRequiredToHide
        
        self.descriptionLbl.isHidden = isRequiredToHide
        
        self.minMaxTemprature.isHidden = isRequiredToHide
        
        self.temprature.isHidden = isRequiredToHide
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // utils
    
    private func tempratureInC (_ tempratureValue: Double?) -> Double
    {
        let temp = (10 * (tempratureValue! - 273.15)) / 10
        
        return temp
    }
}

