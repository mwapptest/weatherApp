//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Wagh, Manoj on 12/16/16.
//  Copyright © 2016 Wagh, Manoj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let str = "{\"coord\": {\"lon\": -0.13,\"lat\": 51.51},\"weather\": [{\"id\":721,\"main\": \"Haze\",\"description\": \"haze\",\"icon\": \"50n\"},{\"id\":741,\"main\": \"Fog\",\"description\": \"fog\",\"icon\": \"50n\"},{\"id\":701,\"main\": \"Mist\",\"description\": \"mist\",\"icon\": \"50n\"}],\"base\":\"stations\",\"main\": { \"temp\": 278.15,\"pressure\": 1035,\"humidity\": 93,\"temp_min\": 275.15,\"temp_max\": 280.15},\"visibility\": 2500,\"wind\": {\"speed\": 0.5},\"clouds\": {\"all\": 88},\"dt\": 1481953800,\"sys\":{ \"type\": 1,\"id\": 5091,\"message\": 0.0067,\"country\": \"GB\",\"sunrise\": 1481961704,\"sunset\": 1481989929},\"id\": 2643743,\"name\": \"London\",\"cod\": 200}"
        
//        let dict = convertToDictionary(text: str)
        
//        print("\(dict)")
        
//        let we = WeatherDataModel.init(dictionary: dict!)
        
        return true
    }
    
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


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

