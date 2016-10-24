//
//  ViewController.swift
//  GGMap Demo
//
//  Created by Đinh Xuân Lộc on 10/18/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    @IBOutlet weak var myPlaceButton: UIBarButtonItem!
    var didFindMyLocation = false
    
    var locationMarker: GMSMarker!
    
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    var locationLat: Double = 0
    var locationLong: Double = 0
    var isFirstLoad:Bool = true
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate            = self
        mapView.delegate                    = self
        locationManager.desiredAccuracy     = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        self.mapView.isMyLocationEnabled    = true
        if let locations = locationManager.location {
            locationLat                     = locations.coordinate.latitude
            locationLong                    = locations.coordinate.longitude
            let camera: GMSCameraPosition   = GMSCameraPosition.camera(withLatitude:locationLat, longitude:locationLong, zoom: 8.0)
            mapView.camera                  = camera
            locationMarker                  = GMSMarker(position: (mapView.myLocation?.coordinate)!)
            let timestamp                   = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            locationMarker.title            = timestamp
            locationMarker.map              = mapView
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        if let mylocation = mapView.myLocation {
//            print("User's location: \(mylocation)")
//            
//            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: (mylocation.coordinate.latitude), longitude: (mylocation.coordinate.longitude), zoom: 8.0)
//            mapView.camera = camera
//            locationMarker = GMSMarker(position: mylocation.coordinate)
//            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
//            locationMarker.title = timestamp
//            locationMarker.map = mapView
//        } else {
//            print("User's location is unknown")
//        }
//        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func myPlaceAction(_ sender: AnyObject) {
        locationMarker = nil
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
            
            let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: (mylocation.coordinate.latitude), longitude: (mylocation.coordinate.longitude), zoom: 8.0)
            mapView.camera = camera
            locationMarker = GMSMarker(position: mylocation.coordinate)
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
            locationMarker.title = timestamp
            locationMarker.map = mapView
        } else {
            print("User's location is unknown")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let locValue:CLLocation = locations.last!
        print("locations = \(locValue.coordinate.latitude) \(locValue.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
}
