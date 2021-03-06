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
import CoreMotion

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var LatLabel: UILabel!
    
    @IBOutlet weak var LongLabel: UILabel!
    
    
    @IBOutlet weak var First_name: UITextField!
    
    @IBOutlet weak var Last_name: UITextField!
    
    @IBOutlet weak var Email_field: UITextField!
    
    @IBOutlet weak var Phone_field: UITextField!
    
    @IBOutlet weak var Home_field: UITextField!
    
    @IBOutlet weak var Height_field: UITextField!
    
    @IBOutlet weak var Hospital_field: UITextField!
    
    @IBOutlet weak var Height_field2: UITextField!
    
    @IBOutlet weak var AltitudeLabel: UILabel!
    
    @IBOutlet weak var PressureLabel: UILabel!
    
    
    lazy var altimeter = CMAltimeter()
    
    
    
    let First = NSUserDefaults.standardUserDefaults()
    let Last =  NSUserDefaults.standardUserDefaults()
    
    let Email = NSUserDefaults.standardUserDefaults()
    let Phone = NSUserDefaults.standardUserDefaults()
    
    let Home =  NSUserDefaults.standardUserDefaults()
    let Height = NSUserDefaults.standardUserDefaults()
    let Height2 = NSUserDefaults.standardUserDefaults()
    
    let Addr = NSUserDefaults.standardUserDefaults()
    
    let Hospital = NSUserDefaults.standardUserDefaults()
    
    var Data2 = String()
    
    
    
    
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
        
        ScrollView.contentSize.height = 1400
        
        if(CMAltimeter.isRelativeAltitudeAvailable()){
       // let altitudedata = CMAltitudeData()
        
          altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (altitudedata:CMAltitudeData?, error:NSError?) in
        print("Hey")
         var altitude = altitudedata!.relativeAltitude.floatValue
         let pressure = altitudedata!.pressure.floatValue
        
        altitude = altitude * (3.28084)
        
         self.AltitudeLabel.text = altitude.description
        
         self.PressureLabel.text = pressure.description
        
         })}
         else{
             print("Barometer not available on this device")
          }
        
        
        
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
            
            Data2 = LabelInfo
            //LatLabel.text = location
            //LongLabel.text = Long
            
            print( subthoroughfare! + " " + thoroughfare! + " " + sublocality! + " " + locality! + " " + postalCode! + " " +  administrativeArea! + " " +  country!)
        }
        
    }
    
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("Errors: " + error.localizedDescription)
        }
        
        
        
    @IBAction func Save_Button(sender: AnyObject) {
        First.setObject(First_name.text, forKey: "First")
        
        Last.setObject(Last_name.text, forKey: "Last")
        
        Email.setObject(Email_field.text, forKey: "Email")
        
        Phone.setObject(Phone_field.text, forKey: "Phone")
        
        Home.setObject(Home_field.text, forKey: "Home")
        
        Height.setObject(Height_field.text, forKey: "Height")
        
        Height2.setObject(Height_field2.text, forKey: "Height2")
        
        Addr.setObject(Label.text, forKey: "Addr")
        
        Hospital.setObject(Hospital_field.text, forKey: "Hospital")
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController : ViewController2 = segue.destinationViewController as! ViewController2
        
        DestViewController.Data = Data2
        
        var Outdata = First.stringForKey("First")
        DestViewController.Data1 = Outdata!
        
        Outdata = Last.stringForKey("Last")
        DestViewController.Data2 = Outdata!
        
        
        
        Outdata = Email.stringForKey("Email")
        DestViewController.Data3 = Outdata!
        
        Outdata = Phone.stringForKey("Phone")
        DestViewController.Data4 = Outdata!
        
        Outdata = Home.stringForKey("Home")
        DestViewController.Data5 = Outdata!
        
        Outdata = Height.stringForKey("Height")
        DestViewController.Data6 = Outdata!
        
        Outdata = Height2.stringForKey("Height2")
        DestViewController.Data8 = Outdata!
        
        Outdata = Hospital.stringForKey("Hospital")
        DestViewController.Data7 = Outdata!
        
    
        
        
        
    }
        
        
        
    


}

