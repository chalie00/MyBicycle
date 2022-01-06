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
    
    
}//End Of The Class

