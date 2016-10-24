//
//  AppDelegate.swift
//  GGMap Demo
//
//  Created by Đinh Xuân Lộc on 10/18/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var alert: UIAlertController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        GMSServices.provideAPIKey("AIzaSyAaRLndXxCr2OQvBXSCrFAl6JZ9_leXr8s")
        GMSPlacesClient.provideAPIKey("AIzaSyAaRLndXxCr2OQvBXSCrFAl6JZ9_leXr8s")
        if !(CLLocationManager.locationServicesEnabled()){
            dismissAlert()
            checkLocationAuthorizationStatus()
        }else{
            dismissAlert()
            
        }
        return true
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
        checkLocationAuthorizationStatus()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func checkLocationAuthorizationStatus() {
        
        let status = CLLocationManager.authorizationStatus()
        switch(status)
        {
        case .authorizedAlways,  .authorizedWhenInUse:
            dismissAlert()
            locationManager.startUpdatingLocation()
            break
            
        case .denied:
            alertDisplay()
            break
            
        case .restricted:
            alertDisplay()
            break
            
        case .notDetermined:
            alertDisplay()
            break
        }
        
    }

    func showAlert(title: String,msg: String,actions:[UIAlertAction]) {
        alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for action in actions {
            alert?.addAction(action)
        }
        self.window?.rootViewController?.present(alert!, animated: true, completion: nil)
    }
    func alertDisplay() {
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        showAlert(title: "Caution", msg: "Not enable Location", actions: [settingsAction])
        
    }
    func dismissAlert(){
        if alert != nil{
            alert?.dismiss(animated: false, completion: nil)
        }
    }
}

