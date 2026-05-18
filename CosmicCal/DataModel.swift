//
//  DataModel.swift
//  
//
//  Created by Student on 5/4/26.
//

import Foundation
import SwiftUI

struct PictureResponse: Codable {
//    var page: Int
    var results: [Picture]
}

struct Picture: Identifiable,Codable {
    var id: Int
    var title: String
    var picture_path: String?
    var explanation: String
    var credit: String
    var media_type: String
}

struct NasaApod: Identifiable, Codable {
    var id: String { date }
    var date: String
    var explanation: String
    var hdurl: String
    var title: String
}

struct WeatherResponse: Codable {
//    var page: Int
    var results: [Weather]
}

struct Weather: Codable {
    var name: String
    var region: String
    var temp_c: Double
    var temp_f: Double
    var last_updated: String
//    var text: String
    var feelslike_c: Double
    var feelslike_f: Double
    var uv: Double
    var change_of_rain: Double
    var change_of_snow: Double
}
