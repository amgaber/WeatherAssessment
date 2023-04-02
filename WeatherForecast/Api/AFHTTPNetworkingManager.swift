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
        manager.get(urlString, parameters: nil,
                    headers: [:], progress: nil,
                    success: {(operation,responseObject) -> Void in
                    print(responseObject)
                    print("success")
                    completionHandler(responseObject, nil)
            
                },failure: { (operation,error) in
                    print("Error: " + error.localizedDescription)
                    let error = Error(errorCode: .NetworkRequestFailed)
                    completionHandler(nil, nil)

                    })
        
        
       
//           let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, networkError) -> Void in
//
//             // Check network error
//             if networkError != nil {
//               let error = Error(errorCode: .NetworkRequestFailed)
//               completionHandler(nil, error)
//               return
//             }
//
//             // Check JSON serialization error
//             guard let unwrappedData = data else {
//               let error = Error(errorCode: .JSONSerializationFailed)
//               completionHandler(nil, error)
//               return
//             }
//
//             let json = JSON(data: unwrappedData)
//
//             // Get temperature, location and icon and check parsing error
//             guard let tempDegrees = json["list"][0]["main"]["temp"].double,
//               country = json["city"]["country"].string,
//               city = json["city"]["name"].string,
//               weatherCondition = json["list"][0]["weather"][0]["id"].int,
//               iconString = json["list"][0]["weather"][0]["icon"].string else {
//                 let error = Error(errorCode: .JSONParsingFailed)
//                 completionHandler(nil, error)
//                 return
//             }
//
//             var weatherBuilder = WeatherBuilder()
//             let temperature = Temperature(country: country, openWeatherMapDegrees:tempDegrees)
//             weatherBuilder.temperature = temperature.degrees
//             weatherBuilder.location = city
//
//             let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
//             weatherBuilder.iconText = weatherIcon.iconText
//
//
//             var forecasts: [Forecast] = []
//             // Get the first four forecasts
//             for index in 0...3 {
//               guard let forecastTempDegrees = json["list"][index]["main"]["temp"].double,
//                 rawDateTime = json["list"][index]["dt"].double,
//                 forecastCondition = json["list"][index]["weather"][0]["id"].int,
//                 forecastIcon = json["list"][index]["weather"][0]["icon"].string else {
//                   break
//               }
//
//               let forecastTemperature = Temperature(country: country, openWeatherMapDegrees: forecastTempDegrees)
//               let forecastTimeString = ForecastDateTime(rawDateTime).shortTime
//               let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
//               let forcastIconText = weatherIcon.iconText
//
//               let forecast = Forecast(time: forecastTimeString,
//                                   iconText: forcastIconText,
//                                temperature: forecastTemperature.degrees)
//
//               forecasts.append(forecast)
//             }
//
//             weatherBuilder.forecasts = forecasts
//
//             completionHandler(weatherBuilder.build(), nil)
//        }
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
       return components.path
}

private func generateRequestURL(url: String, iconID: String) -> String? {
    guard let components = NSURLComponents(string:url) else {
      return nil
    }
    components.path = "/img/w/" + iconID + ".png"
     return components.path
}
