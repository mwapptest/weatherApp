//
//  NetworkHandler.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//

import Foundation
import Alamofire

internal typealias WeatherDataCompletionBlock = (_ response: WeatherDataModel?, _ error: Error?) -> ()

class NetWorkHandler
{
    let WEATHER_API_KEY = "1557effcd0400db0b7319803ed2c3163"
    
    let baseUrl = "http://api.openweathermap.org/data/2.5/weather?q="
    
    let baseImageUrl = "http://openweathermap.org/img/w/"
    
    func fetchCityWeather (cityname:String?, completion:@escaping WeatherDataCompletionBlock)
    {
        let urlForCityWeather = self.baseUrl + cityname! + "&appid=" + self.WEATHER_API_KEY
        
        Alamofire.request(urlForCityWeather).responseJSON {
            response in
                        
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                let weatherReport = WeatherDataModel.init(dictionary: (JSON as? NSDictionary)!)
                
                print("weather Report: \(weatherReport)")
                
                completion(weatherReport, nil)
                return
            }
            
            let error = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError, userInfo: nil)
            completion(nil,error)
            
        }
    }
    
    func downloadImage (imageName: String?, completion:@escaping (_ imageData:UIImage?) -> ())
    {
        let imageUrl = baseImageUrl + imageName! + ".png"
        
        
        Alamofire.request(imageUrl).responseData {
            response in
            if let data = response.result.value
            {
                let image = UIImage(data: data)
                
                if image != nil
                {
                    completion(image)
                }
                else
                {
                    completion(nil)
                }
                return
            }
        }
    }
    
}
