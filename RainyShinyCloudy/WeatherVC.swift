//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/3/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var currentTempLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var currentWeatherLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    // var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        currentWeather = CurrentWeather()
        forecast = Forecast()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
        
    }
    
    func locationAuthStatus(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
//            if Location.sharedInstance.latitude != nil {
//                print("PASSED TEST")
//            } else {
//                print("FAILED TEST")
//            }
            
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
//            if Location.sharedInstance.longitude != nil {
//                print("PASSED TEST")
//            } else {
//                print("FAILED TEST")
//            }
            
            currentWeather.downloadWeatherDetails {
                //Setup UI to load downloaded data
                self.forecast.downloadForecastData {
                    self.tableView.reloadData()
                    self.updateMainUI()
                }
            }

            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.getForecastArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecasts = forecast.getForecastArray()
            let dailyForecast = forecasts[indexPath.row]
            cell.configureCell(forecast: dailyForecast)
            
            return cell
        }else {
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        dateLbl.text = currentWeather.date
        currentWeatherLbl.text = currentWeather.weatherType
        locationLbl.text = currentWeather.cityName
        currentTempLbl.text = "\(currentWeather.currentTemp)°"
        
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
        
//        if Location.sharedInstance.latitude != nil {
//            print("LAT PASSED TEST 2")
//            print(Location.sharedInstance.latitude)
//        } else {
//            print("LAT FAILED TEST 2")
//        }
//        
//        if (Location.sharedInstance.longitude != nil) {
//            print("PASSED TEST 2")
//            print(Location.sharedInstance.longitude)
//        } else {
//            print("FAILED TEST 2")
//        }
        
    }

}

