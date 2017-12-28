//
//  WeatherVC.swift
//  RainyShinyApp
//
//  Created by Maha's Mac on 8/21/17.
//  Copyright © 2017 Maha's Mac. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var tempImageLable: UIImageView!
    @IBOutlet weak var weatherTypeLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currWeather: currentWeather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView.delegate = self
        tableView.dataSource = self
        
      
        currWeather = currentWeather()
        //foreCast = Forecast() 
        
        currWeather.downloadWeatherDetails {
            //setup the UI
            self.downloadForecast {
                self.updateUI()
            }
            
        }

        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        locationAuthStatus()
//    }
    
       func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
//            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
//            Location.sharedInstance.longtitude = currentLocation.coordinate.longitude
            print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            
            currWeather.downloadWeatherDetails {
                //setup the UI
                self.downloadForecast {
                    self.updateUI()
                }
                
            }

            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecast(completed: @escaping DownloadComplete){
        //Download forecast weather for the table view 
        
//        let forecastUrl = URL(string: forecastURL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,Any> {
                
                if let list = dict["list"] as? [Dictionary<String,Any>] {
                    
                    for obj in list {
                        let dayForecast = Forecast(weatherDict: obj)
                        self.forecasts.append(dayForecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
            
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell
        }else {
            
            return WeatherCell()
        }
        
       
    }
    
    
    func updateUI(){
        dateLable.text = currWeather.date
        tempLabel.text = "\(currWeather.currentTemp)°"
        weatherTypeLable.text = currWeather.weatherType
        locationLable.text = currWeather.cityName
        tempImageLable.image = UIImage(named: currWeather.weatherType)
        
    }

    

}

