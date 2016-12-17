//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//
//  WeatherDataModel temporary transition model
//
//

import Foundation

class WeatherDataModel: NSObject
{
    
    internal var dictionary: NSDictionary

    public var cityName: String?

    public var main: String?
    
    public var iconUrl: String?
    
    public var detailsDescription: String?
    
    public var temperature: Double?
    
    public var maxTemp : Double?
    
    public var minTemp : Double?
    
    public var pressure : Double?
    
    public var humidity : Double?
    
    public var errorMessage: String?
    
    public var errorCode : Double?
    
    // init method to parse json dicationary to model object
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        
        // weather array, here we save last object of array
        if let weatherArray = self.dictionary ["weather"] as? NSArray
        {
            for dict in weatherArray        // get latest weather data for time being
            {
                let dictObject = dict as! NSDictionary
                
                self.main = dictObject ["main"] as? String
                
                self.iconUrl = dictObject ["icon"] as? String
                
                self.detailsDescription = dictObject ["description"] as? String
            }
        }
        
        // Main weather related information is available here
        if let weatherMainDictionary = self.dictionary["main"] as? NSDictionary
        {            
            self.temperature = weatherMainDictionary ["temp"] as? Double
            
            self.maxTemp = weatherMainDictionary ["temp_max"] as? Double
            
            self.minTemp = weatherMainDictionary ["temp_min"] as? Double
            
            self.humidity = weatherMainDictionary ["humidity"] as? Double
            
            self.pressure = weatherMainDictionary ["pressure"] as? Double
        }
    
        // city name
        self.cityName = self.dictionary ["name"] as? String
        
        self.errorMessage = self.dictionary ["message"] as? String
        
        self.errorCode = self.dictionary ["cod"] as? Double
    }
}
