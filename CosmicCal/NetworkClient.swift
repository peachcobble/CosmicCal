//
//  NetworkClient.swift
//  
//
//  Created by Student on 5/4/26.
//

import SwiftUI

@Observable
class NetworkClient {
    private(set) var picture: [Picture] = []
    private(set) var pictureDetail: Picture = Picture(id: 0, title: "", picture_path: "", explanation: "", credit: "", media_type: "")
//    private(set) var weather: [Weather] = []
    private(set) var weatherDetail: Weather = Weather(name: "", region: "", temp_c: 0.0, temp_f: 0.0, last_updated: "", feelslike_c: 0.0, feelslike_f: 0.0, uv: 0.0, change_of_rain: 0.0, change_of_snow: 0.0)
    
    func getAPOD() async {
        let urlStr: String = "https://api.nasa.gov/planetary/apod?api_key=bO0O45xYdP4dzt7z8YNGFV4RVcjwSraFGIimsAjn"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let pictureOfDay: PictureResponse = try JSONDecoder ().decode(PictureResponse.self, from: data)
            for image in pictureOfDay.results {
                picture.append(image)
            }
        } catch let error {
            print (error)
        }
    }
    
    func getWeather() async {
        let urlStr: String = "http://api.weatherapi.com/v1/current.json?key=c18a5ce374af4b0c852182435260705&q=11217&aqi=yes"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let currentWeather = try JSONDecoder().decode(Weather.self, from: data)
            weatherDetail = currentWeather
        } catch let error {
            print (error)
        }
    }
}
