//
//  CoursePlanListVC.swift
//  VideoPlayer
//
//  Created by thamizharasan t on 30/08/23.
//
//Privacy - Location When In Use Usage Description
//please allow location access to use our app!
import UIKit
import CoreLocation


class CoursePlanListVC: UIViewController,CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()

       override func viewDidLoad() {
           super.viewDidLoad()
           
           
           
           // Set up CLLocationManager
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization() // Request location access
           locationManager.startUpdatingLocation() // Start receiving location updates
       }
       
       // MARK: - CLLocationManagerDelegate

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else {
               return
           }
           
           // Reverse geocode the coordinates to get the location name
           let geocoder = CLGeocoder()
           geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
               if let error = error {
                   print("Reverse geocoding error: \(error.localizedDescription)")
                   return
               }
               
               if let placemark = placemarks?.first {
                   if let cityName = placemark.locality {
                       print("Current location: \(cityName)")
                       // Update your UI or perform any other actions with the location name here
                   } else {
                       print("Location name not found.")
                   }
               }
           }
           
           // Stop location updates if you only need the location name once
           locationManager.stopUpdatingLocation()
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Location manager error: \(error.localizedDescription)")
       }
   }
