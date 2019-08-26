//
//  MapViewController.swift
//  firstApp
//
//  Created by Aditya Tandon on 2019-07-27.
//  Copyright © 2019 Aditya Tandon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var map: MKMapView!
    
    //MARK:- Properties
    
    var wonderLocation: CLLocation?
    var wonderNewLocation: CLLocation?
    var wonderName : String?
    var currentLocation : CLLocation?
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        setupMapViewCoordinate()
        setupLocationManager()
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func setupMapViewCoordinate() {
        let coordinate = wonderLocation?.coordinate
        let newCoordinate = wonderNewLocation?.coordinate
        
        if let coordinate = coordinate, let name = wonderName {
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            // function to zoom
            centerMapOnLocation(annotation.coordinate)
        }
        if let newCoordinate = newCoordinate {
            let newAnnotation = MKPointAnnotation()
            newAnnotation.title = "New"
            newAnnotation.coordinate = newCoordinate
            map.addAnnotation(newAnnotation)
        }
        map.showsUserLocation = true
    }
    func centerMapOnLocation(_ location: CLLocationCoordinate2D) {
        let radius = 1000
        let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(Double(radius)*2.0), longitudinalMeters: CLLocationDistance(Double(radius)*2.0))
        map.setRegion(region, animated: true)
    }
    
    func setupLocationManager(){
        if CLLocationManager.authorizationStatus() == .notDetermined{
            manager.requestWhenInUseAuthorization()
        }
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self
        manager.stopUpdatingLocation()
    }
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "reusePin")
        view.canShowCallout =  true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        view.pinTintColor = UIColor.red
        
        if annotation.title == "New" {
            view.pinTintColor = UIColor.yellow
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let location = view.annotation
        let launchingOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        if let coordinate = view.annotation?.coordinate {
            let mapItem = location?.mapItem(coordinate: coordinate)
            mapItem?.openInMaps(launchOptions: launchingOptions)
        }
    }
}

extension MKAnnotation {
    func mapItem(coordinate: CLLocationCoordinate2D) -> MKMapItem {
        let placeMark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placeMark)
        return mapItem
    }
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        updateLocation(location)
    }
    
    private func updateLocation(_ currentLocation: CLLocation){
        self.currentLocation = currentLocation
    }
}

