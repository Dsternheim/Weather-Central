//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by David Sternheim on 8/5/17.
//  Copyright © 2017 David Sternheim. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIconImg: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    func configureCell(forecast: Forecast){
        lowTempLbl.text = "\(forecast.lowTemp)°"
        highTempLbl.text = "\(forecast.highTemp)°"
        weatherTypeLbl.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIconImg.image = UIImage(named: forecast.weatherType)
        
        if forecast.weatherType.capitalized == "Clear" {
            backgroundImg.image = UIImage(named: "Sunny.jpg")
            
        } else if forecast.weatherType.capitalized == "Rain" {
            backgroundImg.image = UIImage(named: "Rainy.jpg")
            
        } else if forecast.weatherType.capitalized == "Clouds" {
            backgroundImg.image = UIImage(named: "Cloudy.jpg")
            
        } else if forecast.weatherType.capitalized == "Thunderstorm" {
            backgroundImg.image = UIImage(named: "Stormy.jpg")
            
        } else if forecast.weatherType.capitalized == "Partially Cloudy" {
            backgroundImg.image = UIImage(named: "Partcloudy.jpg")
            
        } else if forecast.weatherType.capitalized == "Snow" {
            backgroundImg.image = UIImage(named: "Snowy.jpg")
            
        }
        
    }
    
   

}
