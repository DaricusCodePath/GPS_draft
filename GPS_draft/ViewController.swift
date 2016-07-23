//
//  ViewController.swift
//  GPS_draft
//
//  Created by DrDunkan on 7/12/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var LatLabel: UILabel!
    
    @IBOutlet weak var LongLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        ScrollView.contentSize.height = 1000
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //Location Delegate Methods
    }
    
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last
            
            let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            
            //print(location!.coordinate.latitude)
            let lat = location!.coordinate.latitude
            let long = location!.coordinate.longitude
            
            LatLabel.text = lat.description
            LongLabel.text = long.description
            
            
            self.mapView.setRegion(region, animated: true)
            
            
            //self.locationManager.stopUpdatingLocation()
            
            
            CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
                
                if (error != nil) {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0]
                    self.displayLocationInfo(pm)
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
                
        
        }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            //locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let sublocality = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality : ""
            let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
            let subthoroughfare = (containsPlacemark.subThoroughfare != nil) ? containsPlacemark.subThoroughfare : ""
            
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            //print( locality! + thoroughfare! + subthoroughfare! + sublocality! + postalCode! +  administrativeArea! +  country!)
            let LabelInfo = (subthoroughfare! + " " + thoroughfare! + " " + sublocality! + " " + locality! + " " + postalCode! + " " +  administrativeArea! + " " +  country!)
            Label.text = LabelInfo
            //LatLabel.text = location
            //LongLabel.text = Long
            
            print( subthoroughfare! + " " + thoroughfare! + " " + sublocality! + " " + locality! + " " + postalCode! + " " +  administrativeArea! + " " +  country!)
        }
        
    }
    
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("Errors: " + error.localizedDescription)
        }
        
        
        
        
        
        
        
        
    


}

