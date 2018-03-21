//
//  FriendMapVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 19/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FriendMapVC: UIViewController {

    var address:String = ""
    var name:String = ""
    var lat:Double! = -33.872749599999999
    var long:Double! = 151.2061827
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapType = MKMapType.standard
        

        
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            self.lat = placemark?.location?.coordinate.latitude
            self.long = placemark?.location?.coordinate.longitude
            //print("Lat: \(lat), Lon: \(lon)")
            
            let location = CLLocationCoordinate2D(latitude: self.lat!,longitude: self.long!)
            
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Personal Oraganiser"
            annotation.subtitle = self.name
            self.mapView.addAnnotation(annotation)
        }
    }

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
