//
//  CommonProtocol.swift
//  Clima
//
//  Created by PavunRaj on 26/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerProtocol: NSObjectProtocol {
     func didupdateWeather(weatherModel: WeatherModel)
    func didupdateWithError(error:Error)
}
