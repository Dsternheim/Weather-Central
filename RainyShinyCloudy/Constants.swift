//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/4/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATTITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "a45d9e8012317a6f7b18ffeff839d578"

typealias DownloadComplete = () -> () //tells func when finished downloading

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATTITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=a45d9e8012317a6f7b18ffeff839d578"
