//
//  ViewController.swift
//  MyBiCycle
//
//  Created by chalie on 2022/01/03.
//

import UIKit
import MapKit

class PlayBicycleVC: UIViewController {

    @IBOutlet weak var startTxtFld: UITextField!
    @IBOutlet weak var endTxtFld: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var disLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedStartBtn(_ sender: UIButton) {
        print("Start Button Pressed")
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

