//
//  MapViewController.swift
//  DemoApp
//
//  Created by Ammad on 04/08/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    var annotations: [CarDetails] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.stopUpdatingLocation()
        zoomToRegion()
        mapAnnotations()
    }
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: 53.59301, longitude: 10.07526)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.addAnnotation(annotation)
        
    }
    
    
    @IBAction func goToMain(_ sender: Any) {
        performSegue(withIdentifier: "gotoMain", sender: nil)
    }
    func mapAnnotations() {
        for point in annotations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude!, longitude: point.longitude!)
            mapView.addAnnotation(annotation)
        }
    }
    
}
