//
//  currentLocationData.swift
//  Weather app
//
//  Created by Сергей Золотухин on 07.01.2022.
//

import Foundation

struct CurrentLocationData: Codable {
    let response: ResponceDetail
}

struct ResponceDetail: Codable {
    let GeoObjectCollection: GeoObjectCollectionDetail
}

struct GeoObjectCollectionDetail: Codable {
    let featureMember: [FeatureMemberDetail]

}

struct FeatureMemberDetail: Codable {
    var GeoObject: GeoObjectDetail
}

struct GeoObjectDetail: Codable {
    let description: String
}
