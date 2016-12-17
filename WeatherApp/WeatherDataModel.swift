//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//

import Foundation

class WeatherDataModel
{
    /*{
     "coord": {
     "lon": -0.13,
     "lat": 51.51
     },
     "weather": [
     {
     "id": 500,
     "main": "Rain",
     "description": "light rain",
     "icon": "10n"
     }
     ],
     "base": "cmc stations",
     "main": {
     "temp": 286.164,
     "pressure": 1017.58,
     "humidity": 96,
     "temp_min": 286.164,
     "temp_max": 286.164,
     "sea_level": 1027.69,
     "grnd_level": 1017.58
     },
     "wind": {
     "speed": 3.61,
     "deg": 165.001
     },
     "rain": {
     "3h": 0.185
     },
     "clouds": {
     "all": 80
     },
     "dt": 1446583128,
     "sys": {
     "message": 0.003,
     "country": "GB",
     "sunrise": 1446533902,
     "sunset": 1446568141
     },
     "id": 2643743,
     "name": "London",
     "cod": 200
     }
     */
    
    internal var dictionary: NSDictionary

    public var cityName: String?

    public var main: String?
    
    public var iconUrl: String?
    
    public var description: String?
    
    private var weatherArray: NSArray?
    
    public var temperature: Double?
    
    public var maxTemp : Double?
    
    public var minTemp : Double?
    
    public var pressure : Double?
    
    public var humidity : Double?
    
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary

        self.weatherArray = self.dictionary ["weather"] as? NSArray
        
        for dict in self.weatherArray!
        {
            let dictObject = dict as! NSDictionary
            
            self.main = dictObject ["main"] as? String
            
            self.iconUrl = dictObject ["icon"] as? String
            
            self.description = dictObject ["description"] as? String
        }
        
        if let weatherMainDictionary = self.dictionary["main"] as? NSDictionary
        {            
            self.temperature = weatherMainDictionary ["temp"] as? Double
            
            self.maxTemp = weatherMainDictionary ["temp_max"] as? Double
            
            self.minTemp = weatherMainDictionary ["temp_min"] as? Double
            
            self.humidity = weatherMainDictionary ["humidity"] as? Double
            
            self.pressure = weatherMainDictionary ["pressure"] as? Double
        }
        
        self.cityName = self.dictionary ["name"] as? String
    }
}
