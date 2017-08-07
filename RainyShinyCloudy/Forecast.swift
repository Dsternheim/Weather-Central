//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/5/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    var forecasts = [Forecast]()
    
    var date: String{
        
        if _date == nil{
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String{
        
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String{
        
        if _highTemp == nil{
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String{
        
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    init(){
        
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            
            if let min = temp["min"] as? Double{
                
                let kelvinToFahrenheitPreDiv = (min * (9/5) - 459.67)
            
                let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDiv/10))
            
                self._lowTemp = "\(kelvinToFahrenheit)"
                
            }
            
            if let max = temp["max"] as? Double{
                
                let kelvinToFahrenheitPreDiv = (max * (9/5) - 459.67)
                
                let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPreDiv/10))
                
                self._highTemp = "\(kelvinToFahrenheit)"
                
            }
            
            if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
                
                if let main = weather[0]["main"] as? String {
                    self._weatherType = main.capitalized
                }
                
            }
            
            if let date = weatherDict["dt"] as? Double{
                let unixConvertedDate = Date(timeIntervalSince1970: date)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.timeStyle = .none
                self._date = unixConvertedDate.dayOfTheWeek()
                
            }
            
        }
        
    }
    
    func getForecastArray() -> [Forecast]{
        return forecasts
    }
    
    func downloadForecastData(completed:@escaping DownloadComplete){
        //Downloads the forecast data to be placed in the TableView
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    var count = 0
                    for obj in list{
                        if count > 0{
                            let forecast = Forecast(weatherDict: obj)
                            self.forecasts.append(forecast)
                            print(obj)
                        }
                        count += 1
                    }
                   
                }
              completed()
            }
            //self.forecasts.removeFirst()
            completed()
        }
        
        
    }
    
}

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
}
