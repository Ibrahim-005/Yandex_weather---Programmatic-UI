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
    var icon : String {
        return weatherICON
    }
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
        //tempMax = (weatherData.forecasts.first?.parts.day.tempMax)!
        //tempMin = (weatherData.forecasts.first?.parts.day.tempMin)!
    }
    
    var weatherICON : String {
        switch condition {
        case "clear":
            return "sun.max"
        case "partly-cloudy":
            return "cloud.sun"
        case "cloudy":
            return "cloud"
        case  "overcast":
            return "cloud.fill"
        case  "drizzle":
            return "cloud.drizzle"
        case "light-rain":
            return "cloud.sun.rain.fill"
        case "rain":
            return "cloud.rain"
        case "moderate-rain":
            return "cloud.moon.rain"
        case "heavy-rain":
            return "cloud.heavyrain"
        case  "showers":
            return "cloud.heavyrain.fill"
        case   "light-snow":
            return "cloud.snow"
        case  "snow":
            return "snowflake"
        case  "hail":
            return "cloud.hail"
        case  "thunderstorm":
            return "cloud.bolt"
        default:
            return "sun.dust"
        }
    }
    
    init(){ }
}
