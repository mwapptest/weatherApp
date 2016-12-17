//
//  WeatherUtils.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/17/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//

import Foundation

class WeatherUtils
{
    class func tempratureInC (_ tempratureValue: Double?) -> Double
    {
        let temp = (10 * (tempratureValue! - 273.15)) / 10
        
        return temp
    }
}
