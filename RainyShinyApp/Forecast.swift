//
//  Forecast.swift
//  RainyShinyApp
//
//  Created by Maha's Mac on 8/22/17.
//  Copyright © 2017 Maha's Mac. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
  
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil{
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    
    
    init(weatherDict: Dictionary<String,Any>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String,Any> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToCels = min - 273.15
                let rounedValue = Double(round(10*kelvinToCels)/10)
                self._lowTemp = "\(rounedValue)°"

                
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToCels = max - 273.15
                let rounedValue = Double(round(10*kelvinToCels)/10)
                self._highTemp = "\(rounedValue)°"
            }
            
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>] {
            
            if let main = weather[0]["main"] as? String {
                
                self._weatherType = main.capitalized
            }
        }
        
        let dt: TimeInterval! = weatherDict["dt"] as! TimeInterval
        let unixConvertedDate = Date(timeIntervalSince1970: dt)
        let weekday = Calendar.current.component(.weekday, from: unixConvertedDate)
        let f = DateFormatter()
        let dayofweek = f.weekdaySymbols[weekday-1]
        
        self._date = dayofweek
    }
    
    

    
    
    
    
}
