//
//  AFHTTPSessionManager.swift
//  WeatherForecast
//
//  Created by Alaa Gaber on 02/04/2023.
//

import Foundation
import AFNetworking

struct AFHTTPNetworkingManager: AFHTTPSessionProtocol {
    
    
    func getWeather(with urlString: String, and cityName: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        let manager = AFHTTPSessionManager()
        guard let url = generateRequestURL(url: urlString,cityName: cityName) else {
             let error = Error(errorCode: .URLError)
             completionHandler(nil, error)
             return
           }
           
           print(url)
//        let request = URLRequest(url: urlString)
        manager.get(url, parameters: nil,
                    headers: [:], progress: nil,
                    success: {(operation,responseObject) -> Void in
                    print(responseObject)
                    print("success")
                    completionHandler(responseObject, nil)
            
                },failure: { (operation,error) in
                    print("Error: " + error.localizedDescription)
                    let error = Error(errorCode: .NetworkRequestFailed)
                    completionHandler(nil, error)

                    })
    }
    
    func getIcon(with urlString: String, and iconID: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let manager = AFHTTPSessionManager()
        guard let url = generateRequestURL(url: urlString,iconID: iconID) else {
             let error = Error(errorCode: .URLError)
            completionHandler(nil, nil, error)
             return
           }
        manager.get(url,
                    parameters: nil,
                    headers: nil,
                    progress: nil,
            success: {(operation,responseObject) -> Void in
            print(responseObject)
            print("success")
            completionHandler(responseObject as! Data, nil, nil)
    
        },failure: { (operation,error) in
            print("Error: " + error.localizedDescription)
            let error = Error(errorCode: .NetworkRequestFailed)
            completionHandler(nil, nil, error)

            })
     
    }
}


  private func generateRequestURL(url: String, cityName: String) -> String? {
      guard let components = NSURLComponents(string:url) else {
        return nil
      }
      
      components.queryItems = [URLQueryItem(name:"q=", value:String(cityName)),
                               URLQueryItem(name:"appKey=", value:String("f5cb0b965ea1564c50c6f1b74534d823"))]
                               //Please sign up for openweather( http://openweathermap.org/appKey ) and put your own appKey here.
      return components.url?.absoluteString
}

private func generateRequestURL(url: String, iconID: String) -> String? {
    guard let components = NSURLComponents(string:url) else {
      return nil
    }
    components.path = "/img/w/" + iconID + ".png"
    return components.url?.absoluteString
}
