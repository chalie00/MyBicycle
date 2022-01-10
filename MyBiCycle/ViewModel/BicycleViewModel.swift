//
//  BicycleViewModel.swift
//  MyBiCycle
//
//  Created by chalie on 2022/01/03.
//

import Foundation
import MapKit
import RxSwift

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
    func getcoordinateFromAddress(_ getAddress: String, mapview:MKMapView) -> (lat: CLLocationDegrees, lon: CLLocationDegrees) {
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
        }
//        let coordinate = CLLocationCoordinate2DMake(resultLatitude!, resultLongtitude!)
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        mapview.region = region
//        let pin = generateAnnotation(lat: resultLatitude!, lon: resultLongtitude!)
//        mapview.addAnnotation(pin)
        
        return (lat: resultLatitude, lon: resultLongtitude)
    }
    
    func generateAnnotation(lat: CLLocationDegrees, lon: CLLocationDegrees) -> MKPointAnnotation {
        let coordinate = CLLocationCoordinate2DMake(lat, lon)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        
        return pin
    }
    
    
    func disStartEndPin(mapview: MKMapView, start: MKPointAnnotation, end: MKPointAnnotation) {
        print("DisPlay")
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let centerLat = (start.coordinate.latitude + end.coordinate.latitude) / 2
        let centerLon = (start.coordinate.longitude + end.coordinate.longitude) / 2
        let coordinate = CLLocationCoordinate2DMake(centerLat, centerLon)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapview.region = region
        print(start)
        print(end)
        
        //            pin.title = "\(getAddress)"
        //            pin.subtitle = "SubTitle"
        mapview.addAnnotation(start)
        //mapview.addAnnotation(end)
        //mapview.addAnnotations([start,end])
        
    }
    
    
}//End Of The Class

