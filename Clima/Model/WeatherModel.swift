//
//  WeatherModel.swift
//  Clima
//
//  Created by PavunRaj on 26/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId:Int
    let temperature: Double
    let name: String
    
    // tempature
//    var temperatureProperty : Double {
//        return round(temperature)
//    }
    
    // Get string
    
    var temperatureProperty : String {
        return String(format: "%.1f", temperature)
    }
    
    // uss the computed property
    
    var conditionName: String {
        
        switch conditionId  {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
           return "cloud"
        }
    }
    
    /*
    func getWeatherCondition(weatherId: Int) -> String {
        
        switch weatherId  {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
           return "cloud"
        }
    }
    */

}
