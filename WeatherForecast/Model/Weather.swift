//
//  Weather.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 02/04/2023.
//

import Foundation

struct Weather {
  let location: String
  let iconText: String
  let temperature: String

  let forecasts: [Forecast]
}

struct Forecast {
  let time: String
  let iconText: String
  let temperature: String
}
