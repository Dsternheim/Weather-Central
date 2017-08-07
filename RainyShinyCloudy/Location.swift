//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/5/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
    
    
}
