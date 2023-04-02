//
//  Error.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 02/04/2023.
//

import Foundation

struct Error {
  enum Code: Int {
    case URLError                 = -6000
    case NetworkRequestFailed     = -6001
    case JSONParsingFailed        = -6003
  }
  
  let errorCode: Code
}
