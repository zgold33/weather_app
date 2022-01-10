//
//  UserDefaultsModel.swift
//  Weather app
//
//  Created by Сергей Золотухин on 10.01.2022.
//

import Foundation

struct Constant {
    static let userKey = "city.user.key"
}

struct CityName: Codable {
    let name: String
}
