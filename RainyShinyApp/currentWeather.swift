//
//  currentWeather.swift
//  RainyShinyApp
//
//  Created by Maha's Mac on 8/21/17.
//  Copyright © 2017 Maha's Mac. All rights reserved.
//

import UIKit
import Alamofire 

class currentWeather {
    
var _cityName: String!
var _date: String!
var _weatherType: String!
var _currentTemp: Double!

var cityName: String {
    if _cityName == nil {
        _cityName = ""
    }
    
    return _cityName
}

var date: String {
    if _date == nil {
        _date = ""
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none

    
    let currentDate =  dateFormatter.string(from: Date())
    self._date = "Today, \(currentDate)"
    
    return _date
}
var weatherType: String {
    if _weatherType == nil {
        _weatherType = ""
    }
    
    return _weatherType
}

var currentTemp: Double {
    if _currentTemp == nil {
        _currentTemp = 0.0
    }
    
    return _currentTemp
}

func downloadWeatherDetails(completed: @escaping DownloadComplete){
    //Alamofire download  
    
    Alamofire.request(currentWeatherURL).responseJSON { response in
        let result = response.result
        
        if let dict = result.value as? Dictionary<String, Any> {
            
            if let name = dict["name"] as? String {
                
                self._cityName = name.capitalized
                print(self._cityName)
            }
            
            if let weather = dict["weather"] as? [Dictionary<String,Any>] {
                
                if let main = weather[0]["main"] as? String {
                    
                    self._weatherType = main.capitalized
                    print(self._weatherType)
                }
            }
            
            if let main = dict["main"] as? Dictionary<String,Any> {
                
                if let currTemp = main["temp"] as? Double {
                    
                    let kelvinToCels = currTemp - 273.15
                    let rounedValue = Double(round(10*kelvinToCels)/10)
                    self._currentTemp = rounedValue
                    print(self._currentTemp)
                }
            }
        
    }
    completed()

}
    }
    
    
    
    
    
    func downloadUlmWeatherDetails(completed: @escaping DownloadComplete){
        //Alamofire download
        
        Alamofire.request(currentWeatherUlmURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String {
                    
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,Any>] {
                    
                    if let main = weather[0]["main"] as? String {
                        
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,Any> {
                    
                    if let currTemp = main["temp"] as? Double {
                        
                        let kelvinToCels = currTemp - 273.15
                        let rounedValue = Double(round(10*kelvinToCels)/10)
                        self._currentTemp = rounedValue
                        print(self._currentTemp)
                    }
                }
                
            }
            completed()
            
        }
    }
    
    
    
}


