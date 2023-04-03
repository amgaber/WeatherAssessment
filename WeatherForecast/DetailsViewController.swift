//
//  DetailsViewController.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 03/04/2023.
//

import UIKit

class DetailsViewController: UIViewController  {
    
    var cityName: String = ""
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network  = AFHTTPNetworkingManager()
        network.getWeather(with: baseURL, and: self.cityName) { response, error in
            print(response)
            print("success")
            
            print(error)
            print("fail")
            
        }
    
        
    }
    
}
