//
//  DataModel.swift
//  
//
//  Created by Student on 5/4/26.
//

import Foundation
import SwiftUI

struct PictureResponse: Codable {
    var results: Picture
}

struct Picture: Codable {
//    var id: Int - Identifiable,
    var title: String
    var url: String?
    var explanation: String
    var media_type: String
}

struct WeatherResponse: Codable {
    var results: [Weather]
}

struct Weather: Codable {
    var name: String
    var region: String
    var temp_c: Double
    var temp_f: Double
    var last_updated: String
    var feelslike_c: Double
    var feelslike_f: Double
    var uv: Double
    var change_of_rain: Double
    var change_of_snow: Double
}
