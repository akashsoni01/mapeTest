//
//  ViewController.swift
//  mapeTest
//
//  Created by ANURAG ADARSH on 18/03/18.
//  Copyright © 2018 ANURAG ADARSH. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var label: UILabel!
    let locManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        self.map.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        print(location.altitude)
        print(location.speed)
        self.map.showsUserLocation = true
        CLGeocoder().reverseGeocodeLocation(location){
            (placemark,error) in
            if (error != nil){
                print("error in line 40")
            }else {
                if let place = placemark?[0]{
                    self.label.text = place.country
                }
            }
        }
    }
}

