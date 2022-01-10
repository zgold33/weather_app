//
//  NetworkWeatherManager.swift
//  Weather app
//
//  Created by Сергей Золотухин on 30.12.2021.
//
//
//import Foundation
//import CoreLocation
//
//struct NetworkWeatherManager {
//    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if !locations.isEmpty, currentLocation == nil {
//            currentLocation = locations.first
//            locationManager.stopUpdatingLocation()
//        }
//    }
//    
//    func requestWeatherForLocation(completionHandler: @escaping (Weather) -> Void ) {
//        guard let currentLocation = currentLocation else {
//            return
//        }
//        let long = currentLocation.coordinate.longitude
//        let lat = currentLocation.coordinate.latitude
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)"
//        guard let url = URL(string: urlString) else { return }
//        
//        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
//        request.httpMethod = "GET"
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print(String(describing: error))
//                return
//            }
//            
//            if let weather = self.parseJSON(withData: data) {
//                completionHandler(weather)
//            }
//        }
//        task.resume()
//    }
//    
//    func parseJSON(withData data: Data) -> Weather? {
//        let decoder = JSONDecoder()
//        do {
//            let weatherData = try decoder.decode(WeatherData.self, from: data)
//            guard let weather = Weather(weatherData: weatherData) else {
//                return nil
//            }
//            return weather
//            
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        return nil
//    }
//}
