//
//  Weather.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 18/07/22.
//

import Foundation

struct Weather {
    
    var name : String = "Name"
    var temperature : Double = 0.0
    var tempString : String {
        return String(format: "%.0f", temperature)
    }
    var conditionCode : String = ""
    var url : String = ""
    var condition : String = ""
    var pressureMm : Double = 0.0
    var windSpeed : Double = 0.0
    var tempMin : Int = 0
    var tempMax : Int = 0
    
    init?(weatherData : WeatherData){
        
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        pressureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
      //  tempMax = (weatherData.forecasts.first?.parts.day.tempMax)!
        //tempMin = (weatherData.forecasts.first?.parts.day.tempMin)!
        
    }
    
    init (){
        
    }
}
