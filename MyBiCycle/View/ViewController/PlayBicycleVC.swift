//
//  ViewController.swift
//  MyBiCycle
//
//  Created by chalie on 2022/01/03.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift

class PlayBicycleVC: UIViewController {

    @IBOutlet weak var startTxtFld: UITextField!
    @IBOutlet weak var endTxtFld: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var disLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    var viewModel: PlayBicycleVM = PlayBicycleVM()
    var locationManager = CLLocationManager()
    var startPin: MKPointAnnotation?
    var endPin: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        startTxtFld.delegate = self
        endTxtFld.delegate = self
        
        //Display the user position after load the viewcontroller
        viewModel.currentPosition(mapView)
    }
    
    //Subscribe the start/end TextFld
    
    
    @IBAction func pressedStartBtn(_ sender: UIButton) {
        print("Start Button Pressed")
        
        mapView.userTrackingMode = .none
        print("startPin: \(startPin)")
        print("endPin: \(endPin)")
        
        if startPin != nil && endPin != nil {
            viewModel.disStartEndPin(mapview: mapView, start: startPin!, end: endPin!)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End Of The Class

extension PlayBicycleVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        viewModel.updateCurrentPosition(mapview: mapView, coordinate: (locations.last?.coordinate)!)
        //아래와 같이 하는게 위의 Code보다 안정적으로 위치를 표기함 (까딱까딱이지 않음)
        //mapView.userTrackingMode = .follow

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .notDetermined, .denied, .restricted:
            break
        default:
            break
        }
    }
    
}

extension PlayBicycleVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == startTxtFld && startTxtFld.text != "" {
            print("StartTxtFld")

            let coordinate = viewModel.getcoordinateFromAddress(startTxtFld.text!, mapview: mapView)
            let pin = viewModel.generateAnnotation(lat: coordinate.lat, lon: coordinate.lon)
            startPin = pin
            mapView.userTrackingMode = .none
            //mapView.addAnnotation(pin)
        }
        
        if textField == endTxtFld && endTxtFld.text != "" {
            print("EndTxtFld")
            let coordinate = viewModel.getcoordinateFromAddress(endTxtFld.text!, mapview: mapView)
            let pin = viewModel.generateAnnotation(lat: coordinate.lat, lon: coordinate.lon)
            endPin = pin
            mapView.userTrackingMode = .none
            //mapView.addAnnotation(pin)
        }
        
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.startTxtFld.isFirstResponder || self.endTxtFld.isFirstResponder) {
            self.startTxtFld.resignFirstResponder()
            self.endTxtFld.resignFirstResponder()
        }
    }
    
}
