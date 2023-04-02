//
//  AFHTTPSessionProtocol.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 02/04/2023.
//

import Foundation


protocol AFHTTPSessionProtocol {
    typealias WeatherCompletionHandler = (Any?, Error?) -> Void
    typealias IconCompletionHandler = (Data?, URLResponse?, Error?) -> Void
   
    func getWeather(with urlString: String, and cityName: String, completionHandler: @escaping WeatherCompletionHandler)
    func getIcon(with urlString: String, and iconID: String, completionHandler: @escaping IconCompletionHandler)
}
