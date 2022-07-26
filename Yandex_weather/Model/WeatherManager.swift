//
//  WeatherManager.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 18/07/22.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather(lat: Double, long: Double , completion: @escaping(Weather) -> Void){
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(long)"
        guard let url = URL(string: urlString) else {return}
      
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("57d81fdc-c7c2-4ea6-8439-7c8e5164ee64", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else{
                return
            }
            if let weatherData = self.parseJson(data){
                completion(weatherData)
            }
        }
        task.resume()
    }
    
    
    func parseJson(_ data: Data) -> Weather? {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: decodedData) else { return nil }
            
            return weather
        }
        catch _ as NSError {
            print("DECODINGGGG__")
        }
        return nil
    }
}





//lat: Double, long: Double , completion: @escaping(Weather) -> Void
//print(String(data: data, encoding: .utf8)!)
