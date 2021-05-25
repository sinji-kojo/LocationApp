//
//  ViewController.swift
//  LocationApp
//
//  Created by PC-SYSKAI551 on 2021/05/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var myTimer: Timer!

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func locationSwitch(sender: UISwitch) {
        if ( sender.isOn ) {
            self.locationLabel.text = "位置情報取得中"
            myTimer = Timer.scheduledTimer(timeInterval: Double(2), target: self, selector: #selector(locationUpdate), userInfo: nil, repeats: true)
            myTimer.fire()

        } else {
            locationLabel.text = "位置情報停止中"
            myTimer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
       if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
     }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("longitude: \(locValue.longitude)  latitude: \(locValue.latitude) ")
//        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            guard let placemark = placemarks?.first, error == nil else { return }
//            guard let administrativeArea = placemark.administrativeArea, // 都道府県
//                            let locality = placemark.locality, // 市区町村
//                            let thoroughfare = placemark.thoroughfare, // 地名(丁目)
//                            let subThoroughfare = placemark.subThoroughfare, // 番地
//                            let postalCode = placemark.postalCode else { return }    //郵便番号
//            print("都道府県:\(administrativeArea) 市区町村:\(locality) 地名(丁目):\(thoroughfare) 番地:\(subThoroughfare) 郵便番号:\(postalCode)")
//        }
       }
    // Timerでループ実行する処理
    @objc func locationUpdate() {
        
       // stop -> start で位置情報更新させる
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
    }
}
