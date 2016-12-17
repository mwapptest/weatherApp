//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//  Unit Testing for weatherdata model, network handler

import XCTest
import Pods_WeatherApp
@testable import WeatherApp

class WeatherAppTests: XCTestCase
{
    private var netWorkHandler: NetWorkHandler?
    
    override func setUp()
    {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.netWorkHandler = NetWorkHandler()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testValidateWeatherDataModel1()
    {
        // some dummy JSON string to create data weather data model
        let str = "{\"coord\": {\"lon\": -0.13,\"lat\": 51.51},\"weather\": [{\"id\":721,\"main\": \"Haze\",\"description\": \"haze\",\"icon\": \"50n\"},{\"id\":741,\"main\": \"Fog\",\"description\": \"fog\",\"icon\": \"50n\"},{\"id\":701,\"main\": \"Mist\",\"description\": \"mist\",\"icon\": \"50n\"}],\"base\":\"stations\",\"main\": { \"temp\": 278.15,\"pressure\": 1035,\"humidity\": 93,\"temp_min\": 275.15,\"temp_max\": 280.15},\"visibility\": 2500,\"wind\": {\"speed\": 0.5},\"clouds\": {\"all\": 88},\"dt\": 1481953800,\"sys\":{ \"type\": 1,\"id\": 5091,\"message\": 0.0067,\"country\": \"GB\",\"sunrise\": 1481961704,\"sunset\": 1481989929},\"id\": 2643743,\"name\": \"London\",\"cod\": 200}"

        let dict = convertToDictionary(text: str)

        let wetherReport1 = WeatherDataModel.init(dictionary: dict!)
        
        XCTAssertEqual(wetherReport1.cityName, "London", "Fail")
        XCTAssertEqual(wetherReport1.temperature, 278.15, "Fail")
        XCTAssertEqual(wetherReport1.maxTemp, 280.15, "Fail")
        XCTAssertEqual(wetherReport1.minTemp, 275.15, "Fail")
        XCTAssertEqual(wetherReport1.description, "mist", "Fail")
        XCTAssertEqual(wetherReport1.pressure, 1035, "Fail")
        XCTAssertEqual(wetherReport1.humidity, 93, "Fail")
    }
    
    func testValidateWeatherDataModel2()
    {
        let str = "{\"coord\": {\"lon\": -0.13,\"lat\": 51.51},\"weather\": [{\"id\":741,\"main\": \"Fog\",\"description\": \"Rain\",\"icon\": \"50n\"}],\"base\":\"stations\",\"main\": { \"temp\": 208,\"pressure\": 777,\"humidity\": 10000,\"temp_min\": 71.2,\"temp_max\": 200},\"visibility\": 2500,\"wind\": {\"speed\": 0.5},\"clouds\": {\"all\": 88},\"dt\": 1481953800,\"sys\":{ \"type\": 1,\"id\": 5091,\"message\": 0.0067,\"country\": \"GB\",\"sunrise\": 1481961704,\"sunset\": 1481989929},\"id\": 2643743,\"name\": \"San Diego\",\"cod\": 200}"
        
        let dict = convertToDictionary(text: str)
        
        let wetherReport1 = WeatherDataModel.init(dictionary: dict!)
        
        XCTAssertEqual(wetherReport1.cityName, "San Diego", "Fail")
        XCTAssertEqual(wetherReport1.temperature, 208, "Fail")
        XCTAssertEqual(wetherReport1.maxTemp, 200, "Fail")
        XCTAssertEqual(wetherReport1.minTemp, 71.2, "Fail")
        XCTAssertEqual(wetherReport1.description, "Rain", "Fail")
        XCTAssertEqual(wetherReport1.pressure, 777, "Fail")
        XCTAssertEqual(wetherReport1.humidity, 10000, "Fail")
    }
    
    
    func testValidateWeatherDataModel3()
    {
        let str = "{\"coord\": {\"lon\": -0.13,\"lat\": 51.51},\"name\": \"San Diego\",\"cod\": 200}"
        
        let dict = convertToDictionary(text: str)
        
        let wetherReport1 = WeatherDataModel.init(dictionary: dict!)
        
        XCTAssertEqual(wetherReport1.cityName, "San Diego", "Fail")
        XCTAssertEqual(wetherReport1.temperature, nil, "Fail")
        XCTAssertEqual(wetherReport1.maxTemp, nil, "Fail")
        XCTAssertEqual(wetherReport1.minTemp, nil, "Fail")
        XCTAssertEqual(wetherReport1.detailsDescription, nil, "Fail")
        XCTAssertEqual(wetherReport1.pressure, nil, "Fail")
        XCTAssertEqual(wetherReport1.humidity, nil, "Fail")
    }
    
    func testWeatherIconImageDownload()
    {
        // valid image
        self.netWorkHandler?.downloadImage(imageName: "10n")
        {
            image in
            
            if image == nil
            {
                XCTFail()
            }
        }
        
        // dummy some image
        self.netWorkHandler?.downloadImage(imageName: "111ZX0n")
        {
            image in
            
            if image != nil
            {
                XCTFail()
            }
        }
    }
    
    func testWeatherAsynDataDownloadRequest()
    {
        // Fetch city weather
        self.netWorkHandler?.fetchCityWeather(cityname: "San Diego")
        {
            weatherResponse, error in
            
            if error != nil
            {
                XCTFail()
            }
            else
            {
                if (weatherResponse != nil)
                {
                    XCTAssertEqual(weatherResponse?.cityName, "San Diego", "Fail")
                }
                else
                {
                    XCTFail()
                }
            }
        }
    }
    
    func testTempratureInC()
    {
        // test for converting temprature in celcius, this will give your double with decimal point which needs to be rounded for testing purpose
        let temp1 = round(WeatherUtils.tempratureInC(221.2))
        
        XCTAssertEqual(temp1, -52, "Fail")
        
        let temp2 = round(WeatherUtils.tempratureInC(301.2))
        
        XCTAssertEqual(temp2, 28, "Fail")
        
    }
    
    // utility to convert string to dictionary
    func convertToDictionary(text: String) -> NSDictionary? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
