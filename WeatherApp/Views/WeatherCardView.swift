//
//  WeatherCardView.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/17/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//
//  This class is basic weather card view, for initialize, customize. 
//  Also this class is repsonsible to display weather card or
//  hide weather card depends on weather data availabilty on Weather view controller
//

import Foundation
import UIKit

class WeatehrCardView: UIView
{
    @IBOutlet weak var minMaxTemprature: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var temprature: UILabel!
    
    @IBOutlet weak var pressure: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.customiseCard()
    }
    
    // some cosmatic modification with weather view card
    private func customiseCard()
    {
        self.layer.cornerRadius = 10    // round corner
        
        self.layer.shadowColor = UIColor.black.cgColor  // some shadow
        
        self.layer.shadowOffset = CGSize.zero       // no offset
        
        self.layer.shadowOpacity = 0.5  // half transparent
        
        self.layer.shadowRadius = 5         // give some more beauty
    }
    
    // Display weather card with updated latest weather data
    public func displayWeatherDataUI(weatherData: WeatherDataModel)
    {
        self.hideWeatherUI(false)
        
        // Display data depend as per weather data model
        self.descriptionLbl.text = weatherData.detailsDescription
        
        self.temprature.text = String(format:"%.1fº",WeatherUtils.tempratureInC(weatherData.temperature!))
        
        self.minMaxTemprature.text = String(format:"Min / Max:   %.1fº / %.1fº",WeatherUtils.tempratureInC(weatherData.minTemp!),WeatherUtils.tempratureInC(weatherData.maxTemp!))
        
        self.pressure.text = String(format: "Pressure: %.1f", weatherData.pressure!)
        
        self.humidity.text = String(format: "Humidity: %.1f", weatherData.humidity!)
        
    }
    
    // hide the weather card for new entry
    public func hideWeatherUI(_ isRequiredToHide: Bool)
    {
        self.isHidden = isRequiredToHide
        
        self.iconImage.isHidden = isRequiredToHide
        
        self.descriptionLbl.isHidden = isRequiredToHide
        
        self.minMaxTemprature.isHidden = isRequiredToHide
        
        self.temprature.isHidden = isRequiredToHide
        
        self.pressure.isHidden = isRequiredToHide
        
        self.humidity.isHidden = isRequiredToHide
        
        // keep place holder if icon will not available
        if isRequiredToHide
        {
            self.iconImage.image = UIImage.init(named: "WeatherPlaceHolder.png")
        }
    }
    
    public func displayDownloadedIcon(image: UIImage?)
    {
        if image != nil // success
        {
            self.iconImage.image = image
        }
        else // fail, no need to display error here or make it placeholder
        {
            self.iconImage.image = UIImage.init(named: "WeatherPlaceHolder.png")
        }
    }
    
}
