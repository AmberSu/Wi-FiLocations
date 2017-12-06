//
//  ViewController.swift
//  Wi-Fi Locations
//
//  Created by MacOS on 01/12/2017.
//  Copyright © 2017 amberApps. All rights reserved.
//

import UIKit
import CoreLocation
import NetworkExtension

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var locationValues = [CLLocation]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assignLocationAttributes()
        let a = NEHotspotHelper.supportedNetworkInterfaces()
        print(a?.count)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: LocationManager methods
    
    func assignLocationAttributes() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.last?.coordinate)
        locationValues.append(locations.last!)
        self.tableView.reloadData()
    }
    
//    func checkLocationValue() -> CLLocation? {
//        if locationValues.count == 1 {
//            return locationValues[0]
//        } else {
//            for n in 0...locationValues.count {
//                let location = locationValues[n]
//                let newLocation = locationValues[n+1]
//
//                if newLocation.coordinate.latitude != location.coordinate.latitude && newLocation.coordinate.longitude != location.coordinate.longitude {
//                    print(newLocation.coordinate.latitude)
//                    print(newLocation.coordinate.longitude)
//                    return newLocation
//                }
//            }
//        }
//        return nil
//    }
    
    // MARK: TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuse") as! TableViewCell

        let location = locationValues[indexPath.row]
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        cell.textLabel?.text = String(latitude) + " " + String(longitude)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

