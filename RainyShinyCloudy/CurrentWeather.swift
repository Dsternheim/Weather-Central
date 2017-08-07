//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/4/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String{
        if _cityName == nil{
            _cityName=""
        }
        return _cityName
    }
    
    var date: String{
        if _date == nil{
            _date=""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long //the style of the date which will be presented onto the app i.e .long will be presented as "Month Day,YEAR"
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date()) // create a string from the current date 
        self._date="Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double{
        if _currentTemp == nil {
            _currentTemp=0.0
        }
        return _currentTemp
    }
    
    
    
    //reads in the data from the JSON file
    func downloadWeatherDetails(completed:@escaping DownloadComplete){
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
            
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let currentTemp = main["temp"] as? Double{
                        
                        let kelvinToFahrenheitPreDiv = (currentTemp * (9/5) - 459.67)
                        
                        let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDiv/10))
                        
                        self._currentTemp = kelvinToFahrenheit
                        print(self._currentTemp)
                    }
                    
                }
                
            }
            completed()
        }
        completed()
    }
}
