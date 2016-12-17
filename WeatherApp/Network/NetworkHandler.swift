//
//  NetworkHandler.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//
//  Using Almofire 3rd party framework for networking, 
//  this class will manage different type of webservice calls
//  to get weather data, create weather model and download respected weather icon
//


import Foundation
import Alamofire

// Completion block for weather data request
internal typealias WeatherDataCompletionBlock = (_ response: WeatherDataModel?, _ error: Error?) -> ()

class NetWorkHandler
{
    // My API key
    let WEATHER_API_KEY = "1557effcd0400db0b7319803ed2c3163"
    
    // base url for weather web server
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q="
    
    // base image url for weather web server
    let baseImageUrl = "http://openweathermap.org/img/w/"
    
    // Fetch city weather data from web server, with city name as input parameter
    // Output parameter as WeatherDataCompletion handler
    // if call get success it return WeatherDataCompletion with WeatherDataModel object
    // if call get fail it return WeatherDataModel as nil with error message
    
    func fetchCityWeather (cityname:String?, completion:@escaping WeatherDataCompletionBlock)
    {
        let escapedCityAddress = cityname?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let urlForCityWeather = self.baseUrl + escapedCityAddress! + "&appid=" + self.WEATHER_API_KEY
        
        // Generic request here
        Alamofire.request(urlForCityWeather).responseJSON
        {
            response in
                        
            if let JSON = response.result.value
            {
                print("JSON: \(JSON)")// TODO MW will remove
                
                let weatherReport = WeatherDataModel.init(dictionary: (JSON as? NSDictionary)!)
                
                completion(weatherReport, nil)
                return
            }
            else if response.result.error == nil
            {
                // incase if server do not send any data with status code 200
                completion(nil,nil)
                return
            }
            
            // Error here
            completion(nil,response.result.error)
        }
    }
    
    // Download Async weather icon image from web server
    func downloadImage (imageName: String?, completion:@escaping (_ imageData:UIImage?) -> ())
    {
        // We assume image will be in png file
        let imageUrl = baseImageUrl + imageName! + ".png"
        
        // Generic request to download data from server
        Alamofire.request(imageUrl).responseData {
            response in
            
            // success if result has any image value
            if let data = response.result.value
            {
                let image = UIImage(data: data)
                
                // success
                if image != nil
                {
                    completion(image)
                }
                else
                {
                    // Error if image not available, return nil value
                    completion(nil)
                }
                return
            }
            // error incase if network fail or other issue
            completion(nil)
            return
        }
    }
}
