//
//  WeatherManager.swift
//  Clima
//
//  Created by PavunRaj on 23/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation



struct WeatherManager {
    
    var delegate: WeatherManagerProtocol?
    let baseWeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1613ddfb21e014ccd3f7b4fdaa286018"
    
    func fetchWeather(cityName: String, longitude:Double, latitute: Double) {
        let fetchWeatherURL =   (cityName != "")  ? "\(baseWeatherURL)&q=\(cityName)" : "\(baseWeatherURL)&lat=\(latitute)&lon=\(longitude)"
        print("URL:",fetchWeatherURL)
        weatherRequest(with: fetchWeatherURL)
    }
    
    
    func weatherRequest(with baseURL:String) {
        
        // 1. create a url
        if let url = URL(string: baseURL) {
            
            // 2. create a URL Session
            
            let session = URLSession(configuration: .default)

            // 3. Create a perform the task
            
            let task =  session.dataTask(with: url, completionHandler: { data, error, response in
                if error == nil {
                    print(error)
                    self.delegate?.didupdateWithError(error: error as! Error)
                    return
                }
                if let safeData = data {
//                   let result = String(data: safeData, encoding: .utf8)
//                   print("Result: ",result ?? "")
                    if let weather = parseTheJSON(safeData) {
                        self.delegate?.didupdateWeather(weatherModel: weather)
                    }
                }
                
            })
            
            task.resume()
        }
    }
    
    func parseTheJSON(_ data:Data) -> WeatherModel?{
        let decode = JSONDecoder()
        do {
            let decodeData = try? decode.decode(WeatherData.self, from: data)
            let id = decodeData?.weather?[0].id ?? 0
            let tempature = decodeData?.main?.temp ?? 0.0
            let name = decodeData?.name ?? ""
            let weatherModel = WeatherModel(conditionId: id, temperature: tempature, name: name)
            
           // let condition = weatherModel.getWeatherCondition(weatherId: weatherModel.conditionId ?? 0)
//            let condition = weatherModel.conditionId
//            let tempatureP = weatherModel.temperatureProperty
//            print(tempatureP)
            return weatherModel
        } catch {
            print("error:",error)
            self.delegate?.didupdateWithError(error: error)

            return nil
        }
  
    }
    
    
  
}


