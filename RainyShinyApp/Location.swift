//
//  Location.swift
//  RainyShinyApp
//
//  Created by Maha's Mac on 8/23/17.
//  Copyright © 2017 Maha's Mac. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longtitude: Double!
    
}
