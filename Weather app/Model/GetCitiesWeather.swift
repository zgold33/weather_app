//
//  GetCitiesWeather.swift
//  Weather app
//
//  Created by Сергей Золотухин on 29.12.2021.
//

//import Foundation
//
//import CoreLocation
//
//let networkWeatherManager = NetworkWeatherManager()
//
////перебираем массив и записываем в новый, подставляем вместо стринг название и в комплишенХендлер передаем индекс каждого города и его погоду
//func getCityWeather(citiesArray: [String], compleationHandler: @escaping (Int, Weather) -> Void) {
//
//    for (index, item) in citiesArray.enumerated() {
//
//        getCoordinateFrom(city: item) { (coordinate, error) in
//            guard let coordinate = coordinate, error == nil else { return }
//
//            //когда мы получаем координаты, мы подставляем их в функцию
//            networkWeatherManager.fetchWeather(lattitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
//                compleationHandler(index, weather)
//            }
//        }
//    }
//}
//
////определяем координаты города
//func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
//
//    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
//        completion(placemark?.first?.location?.coordinate, error)
//    }
//}
