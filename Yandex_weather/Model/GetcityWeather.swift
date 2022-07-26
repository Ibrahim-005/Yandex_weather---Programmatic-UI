//
//  GetcityWeather.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 18/07/22.
//

import UIKit
import CoreLocation

let weatherManager = WeatherManager()

func getWeather(cityArray: [String] , completion : @escaping(Int, Weather) -> Void){
    for (index1 , item) in cityArray.enumerated() {
       
        getCoordinate(city: item) { conrdinat, error in
            guard let coordinate = conrdinat , error == nil else {return}
            
            weatherManager.fetchWeather(lat: coordinate.latitude, long: coordinate.longitude) { weather in
                completion(index1, weather)
            }
        }
    }
}


func getCoordinate(city: String , completion: @escaping(_ conrdinat : CLLocationCoordinate2D?, _ error: Error?) -> Void) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
