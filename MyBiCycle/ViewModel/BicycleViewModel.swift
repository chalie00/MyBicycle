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
    
    typealias completionHandler = (_ Success: Bool) -> ()
    
    var resultLatitude: CLLocationDegrees?
    var resultLongtitude: CLLocationDegrees?
    var startPin: MKPointAnnotation?
    var endPin: MKPointAnnotation?
    var polyLine: MKPolyline!
    
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
    func getcoordinateFromAddress(_ getAddress: String, mapview:MKMapView, completionHandler: @escaping completionHandler){
        CLGeocoder().geocodeAddressString(getAddress) {
            placeMarks, error in
            if let lat = placeMarks?.first?.location?.coordinate.latitude {
                self.resultLatitude = lat
            }
            
            if let lon = placeMarks?.first?.location?.coordinate.longitude {
                self.resultLongtitude = lon
            }
            if (self.resultLatitude != nil) && (self.resultLongtitude != nil) {
                completionHandler(true)
            }
        }
    }
    
    func generateAnnotation(pinStr: String, lat: CLLocationDegrees, lon: CLLocationDegrees, completionHandler: @escaping completionHandler) {
        let pin = MKPointAnnotation()
        
        if pinStr == "start" {
            startPin = pin
            completionHandler(true)
        }
        if pinStr == "end" {
            endPin = pin
            completionHandler(true)
        }
    }
    
    func disStartEndPin(mapview: MKMapView, start: MKPointAnnotation, end: MKPointAnnotation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let centerLat = (start.coordinate.latitude + end.coordinate.latitude) / 2
        let centerLon = (start.coordinate.longitude + end.coordinate.longitude) / 2
        let coordinate = CLLocationCoordinate2DMake(centerLat, centerLon)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapview.region = region
        mapview.addAnnotation(start)
    }
    
    //Draw the Route
    func drawTheRoute(mapview: MKMapView, start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: start)
        let destinationPlaceMark = MKPlacemark(coordinate: end)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            response, error in
            guard let directionResponse = response else {
                if let error = error {
                    print("Direction Error:\(error)")
                }
                return
            }
            DispatchQueue.main.async {
                let route = directionResponse.routes[0]
                self.polyLine = route.polyline
                mapview.addOverlay(self.polyLine)

                let rect = route.polyline.boundingMapRect
                mapview.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    
    
    
}//End Of The Class

