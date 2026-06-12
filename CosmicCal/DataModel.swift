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
    var title: String
    var url: String?
    var explanation: String
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

struct MoonResponse: Decodable {
    let image: MoonImage
    let phase: Double
    let age: Double
}

struct MoonImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}
