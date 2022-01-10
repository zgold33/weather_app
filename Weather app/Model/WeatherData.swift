//
//  WeatherModel.swift
//  Weather app
//
//  Created by Сергей Золотухин on 29.12.2021.
//

import Foundation

struct WeatherData: Codable {

    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DayWeather]
    let lat: Double
    let lon: Double
    let timezone: String
}

struct CurrentWeather: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let wind_speed: Double
    let weather: [WeatherArray]
}

struct WeatherArray: Codable {
    let icon: String
    let main: String
}

struct HourlyWeather: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let wind_speed: Double
    let weather: [HourlyWeatherCondition]
}

struct HourlyWeatherCondition: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct DayWeather: Codable {
    let dt: Int
    let temp: Temp
    let feels_like: Feels_like
    let humidity: Int
    let wind_speed: Double
    let weather: [DailyWeatherCondition]
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Feels_like: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct DailyWeatherCondition: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

