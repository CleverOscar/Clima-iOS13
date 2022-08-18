//
//  WeatherManager.swift
//  Clima
//
//  Created by Oscar Pacheco on 8/18/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=959e8cf42d66035fd30c18bcb2f0c1e4&units=imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        
        performRequst(urlString: urlString)
    }
    
    func performRequst(urlString: String){
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                
                if let safeData = data {
                    print(parseJSON(weatherData: safeData))
                }
            }
            
            // start the task
            task.resume()
        }
    }
    
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder();
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        
        
    }
    
}
