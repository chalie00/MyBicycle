//
//  BicycleViewModel.swift
//  MyBiCycle
//
//  Created by chalie on 2022/01/03.
//

import Foundation
import MapKit

class PlayBicycleVM {
    
    //Current Position
    func currentPosition(_ mapview: MKMapView) {
        print("complete load the user position")
        var region: MKCoordinateRegion = mapview.region
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapview.setRegion(region, animated: true)
        
        mapview.showsUserLocation = true
        mapview.userTrackingMode = .followWithHeading
        
    }
    
    //Set the user' position to center when changed the user position
    func updateCurrentPosition(mapview: MKMapView, coordinate: CLLocationCoordinate2D) {
        var region: MKCoordinateRegion = mapview.region
        region.center = coordinate
        mapview.setRegion(region, animated: true)
    }
    
    //get the longtitude ans latitude from address String
    func getcoordinateFromAddress(_ getAddress: String, mapview: MKMapView) {
        var resultLatitude: CLLocationDegrees!
        var resultLongtitude: CLLocationDegrees!
        
        CLGeocoder().geocodeAddressString(getAddress) {
            placeMarks, error in
            if let lat = placeMarks?.first?.location?.coordinate.latitude {
                print("lattitude: \(lat)")
                resultLatitude = lat
            }
            
            if let lon = placeMarks?.first?.location?.coordinate.longitude {
                print("longtitude: \(lon)")
                resultLongtitude = lon
            }
            
            if (resultLatitude != nil && resultLongtitude != nil) {
                let coordinate = CLLocationCoordinate2DMake(resultLatitude, resultLongtitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                mapview.region = region
                
                //Mark the location obtained from the address as a pin on the map
                let pin = MKPointAnnotation()
                pin.title = "\(getAddress)"
                pin.subtitle = "SubTitle"
                pin.coordinate = coordinate
                mapview.addAnnotation(pin)
                
            }
            
            
        }
    }
    
    
    
}//End Of The Class

